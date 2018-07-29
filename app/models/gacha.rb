# frozen_string_literal: true

class Gacha < ApplicationRecord
  validates :name, presence: true
end
