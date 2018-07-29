# frozen_string_literal: true

class Gacha < ApplicationRecord
  has_many :gacha_groups, dependent: :destroy

  validates :name, presence: true
end
