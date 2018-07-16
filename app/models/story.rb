# frozen_string_literal: true

class Story < ApplicationRecord
  belongs_to :chapter

  validates :name, presence: true
end
