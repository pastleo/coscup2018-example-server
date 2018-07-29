# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Character, type: :model do
  it { should validate_presence_of(:name) }
  it { should have_many(:relationships) }
  it { should have_many(:users).through(:relationships) }
end
