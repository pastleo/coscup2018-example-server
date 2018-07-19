# frozen_string_literal: true

require 'rails_helper'

RSpec.describe UserMission, type: :model do
  it { should belong_to(:user) }
  it { should belong_to(:mission) }
end
