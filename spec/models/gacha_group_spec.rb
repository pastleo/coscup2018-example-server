# frozen_string_literal: true

require 'rails_helper'

RSpec.describe GachaGroup, type: :model do
  it { should belong_to(:gacha) }
end
