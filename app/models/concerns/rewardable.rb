# frozen_string_literal: true

module Rewardable
  class UnsupportRewardError < StandardError; end
  extend ActiveSupport::Concern

  included do
    has_many :gacha_items, as: :rewardable, dependent: :destroy
  end

  # TODO: Prevent switch/case
  def reward_to(user)
    case self
    when Character then reward_character_to(user)
    else raise 'Unsupport reward'
    end
  end

  private

  def reward_character_to(user)
    # TODO: Give item as reward if
    # user already connected with character
    return if user.characters.include?(self)
    user.characters << self
  end
end
