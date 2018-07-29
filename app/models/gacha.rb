# frozen_string_literal: true

class Gacha < ApplicationRecord
  has_many :groups, class_name: 'GachaGroup', dependent: :destroy

  validates :name, presence: true

  def draw
    lottery = Lottery.new(groups)
    group = lottery.draw
    Lottery.new(group.items).draw
  end
end
