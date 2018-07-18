require 'rails_helper'

RSpec.describe Story, type: :model do
  it { should validate_presence_of(:name) }
  it { should validate_uniqueness_of(:order).scoped_to(:chapter_id) }
end
