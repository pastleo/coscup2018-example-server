# frozen_string_literal: true

class UserMission < ApplicationRecord
  belongs_to :user
  belongs_to :mission, polymorphic: true
end
