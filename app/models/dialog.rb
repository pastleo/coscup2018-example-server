# frozen_string_literal: true

class Dialog < ApplicationRecord
  belongs_to :mission, polymorphic: true

  validates :script, presence: true
end
