# frozen_string_literal: true

FactoryBot.define do
  factory :chapter do
    name { Faker::Name.name }
    sequence(:order) { |i| i }
  end
end
