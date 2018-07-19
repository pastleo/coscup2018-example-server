# frozen_string_literal: true

FactoryBot.define do
  factory :user_mission do
    user { create(:user) }
    completed false
    progress 0

    trait :story do
      mission { create(:story) }
    end
  end
end
