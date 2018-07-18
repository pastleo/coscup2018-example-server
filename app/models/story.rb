# frozen_string_literal: true

class Story < ApplicationRecord
  belongs_to :chapter
  has_many :dialogs, as: :mission, dependent: :destroy

  validates :name, presence: true
  validates :order, uniqueness: { scope: :chapter_id }
end
