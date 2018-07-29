# frozen_string_literal: true

FactoryBot.define do
  factory :gacha_item do
    # TODO: Add supported rewardable item
    rewardable { nil }
    group { create(:gacha_group) }
    weight 1
    amount 1
  end
end
