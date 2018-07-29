# frozen_string_literal: true

FactoryBot.define do
  factory :user_character_replationship do
    user { create(:user) }
    character { create(:character) }
    favorability 1
  end
end
