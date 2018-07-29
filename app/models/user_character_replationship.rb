# frozen_string_literal: true

class UserCharacterReplationship < ApplicationRecord
  belongs_to :user
  belongs_to :character

  validates :character_id, uniqueness: { scope: :user_id }
  validates :favorability, numericality: {
    only_integer: true, greater_than_or_equal_to: 0,
    less_than_or_equal_to: 10_000
  }
end
