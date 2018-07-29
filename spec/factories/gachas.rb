# frozen_string_literal: true

FactoryBot.define do
  factory :gacha do
    name { Faker::Name.name }
  end
end
