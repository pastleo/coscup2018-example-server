# frozen_string_literal: true

FactoryBot.define do
  factory :dialog do
    script { Faker::Lorem.sentence }
    sequence(:order)

    trait :for_story do
      mission { create(:story) }
    end
  end
end
