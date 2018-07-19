# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    username { Faker::Internet.user_name }
    password { Faker::Internet.password }
  end
end
