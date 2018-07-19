# frozen_string_literal: true

class UserMission < ApplicationRecord
  belongs_to :user
  belongs_to :mission, polymorphic: true

  scope :incomplete, -> { where(canceled_at: nil, completed: false) }

  def cancel
    update(canceled_at: Time.zone.now)
    mission
  end
end
