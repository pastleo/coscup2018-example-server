# frozen_string_literal: true

FactoryBot.define do
  factory :gacha_item do
    # TODO: Add supported rewardable item
    rewardable { nil }
    gacha_group { create(:gacha_item) }
    weight 1
    amount 1
  end
end
