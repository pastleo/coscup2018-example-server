# frozen_string_literal: true

class UserMission < ApplicationRecord
  belongs_to :user
  belongs_to :mission, polymorphic: true

  scope :incomplete, -> { where(canceled_at: nil, completed: false) }

  def cancel
    update!(canceled_at: Time.zone.now)
    self
  end

  def next
    dialog = next_dialog

    # TODO: Return correct complete response
    transaction do
      if dialog.present?
        increment(:progress).save
        dialog
      else
        update(completed: true)
        self
      end
    end
  end

  def next_dialog
    mission
      .dialogs
      .find_by(order: (progress + 1)..Float::INFINITY)
  end
end
