# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  subject { build(:user) }

  it { should validate_presence_of(:username) }
  it { should validate_uniqueness_of(:username).case_insensitive }
  it { should have_many(:relationships) }
  it { should have_many(:characters).through(:relationships) }
end
