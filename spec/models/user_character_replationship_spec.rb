# frozen_string_literal: true

require 'rails_helper'

RSpec.describe UserCharacterReplationship, type: :model do
  subject { build(:user_character_replationship) }

  it { should belong_to(:user) }
  it { should belong_to(:character) }

  it { should validate_uniqueness_of(:character_id).scoped_to(:user_id) }
  it do
    should validate_numericality_of(:favorability)
      .only_integer
      .is_less_than_or_equal_to(10_000)
      .is_greater_than_or_equal_to(0)
  end
end
