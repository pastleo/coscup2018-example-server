# frozen_string_literal: true

class GachaGroup < ApplicationRecord
  belongs_to :gacha
  has_many :gacha_items, dependent: :destroy
end
