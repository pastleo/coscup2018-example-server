# frozen_string_literal: true

class Character < ApplicationRecord
  # TODO: Implement RewardItem instead may better
  include Rewardable

  has_many :relationships, class_name: 'UserCharacterReplationship',
                           dependent: :destroy
  has_many :users, through: :relationships

  validates :name, presence: true
end
