# frozen_string_literal: true

class GachaGroup < ApplicationRecord
  belongs_to :gacha
  has_many :items, class_name: 'GachaItem', dependent: :destroy
end
