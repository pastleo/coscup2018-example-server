# frozen_string_literal: true

class GachaItem < ApplicationRecord
  belongs_to :rewardable, polymorphic: true
  belongs_to :group, class_name: 'GachaGroup', foreign_key: :gacha_group_id,
                     inverse_of: :items

  # TODO: Prevent switch/case
  def reward_to(user)
    case rewardable
    when Character then reward_character_to(user)
    else raise 'Unsupport reward'
    end
  end

  private

  def reward_character_to(user)
    # TODO: Give item as reward if
    # user already connected with character
    return if user.characters.include?(rewardable)
    user.characters << rewardable
  end
end
