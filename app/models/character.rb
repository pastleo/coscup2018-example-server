# frozen_string_literal: true

class Character < ApplicationRecord
  validates :name, presence: true
end
