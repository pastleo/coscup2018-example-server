# frozen_string_literal: true

FactoryBot.define do
  factory :gacha_group do
    weight 1
    gacha { create(:gacha) }
  end
end
