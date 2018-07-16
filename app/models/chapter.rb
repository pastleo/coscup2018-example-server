# frozen_string_literal: true

class Chapter < ApplicationRecord
  has_many :stories, dependent: :destroy

  validates :name, presence: true
end
