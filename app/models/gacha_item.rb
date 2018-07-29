# frozen_string_literal: true

class GachaItem < ApplicationRecord
  belongs_to :rewardable, polymorphic: true
  belongs_to :group, class_name: 'GachaGroup', foreign_key: :gacha_group_id,
                     inverse_of: :items
end
