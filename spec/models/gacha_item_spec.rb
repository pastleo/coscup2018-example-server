# frozen_string_literal: true

require 'rails_helper'

RSpec.describe GachaItem, type: :model do
  it { should belong_to(:gacha_group) }
  it { should belong_to(:rewardable) }
end
