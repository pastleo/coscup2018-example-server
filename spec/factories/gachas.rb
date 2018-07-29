# frozen_string_literal: true

FactoryBot.define do
  factory :gacha do
    name { Faker::Name.name }

    trait :opened do
      opened true
    end
  end
end
