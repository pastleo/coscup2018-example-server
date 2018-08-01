# frozen_string_literal: true

class Dialog < ApplicationRecord
  belongs_to :mission, polymorphic: true
  belongs_to :character, optional: true

  enum character_expression: {
    normal: 0,
    smile:  1
  }

  validates :script, presence: true
  validates :order, uniqueness: { scope: %i[mission_id mission_type] }

  default_scope -> { order(order: :asc) }
end
