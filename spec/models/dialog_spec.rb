# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Dialog, type: :model do
  it { should validate_presence_of(:script) }
  it do
    should validate_uniqueness_of(:order)
      .scoped_to(%i[mission_id mission_type])
  end
end
