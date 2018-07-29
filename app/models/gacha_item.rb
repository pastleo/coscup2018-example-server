# frozen_string_literal: true

class GachaItem < ApplicationRecord
  belongs_to :rewardable, polymorphic: true
  belongs_to :gacha_group
end
