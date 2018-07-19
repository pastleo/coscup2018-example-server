# frozen_string_literal: true

FactoryBot.define do
  factory :story do
    name { Faker::Name.name }
    sequence(:order)
    chapter { create(:chapter) }
  end
end
