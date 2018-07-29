# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :payments, dependent: :destroy

  has_many :relationships, class_name: 'UserCharacterReplationship',
                           dependent: :destroy
  has_many :characters, through: :relationships
  has_many :missions, dependent: :destroy, class_name: 'UserMission'

  validates :username, uniqueness: { case_sensiive: false }, presence: true

  include User::Mission

  private

  def email_required?
    false
  end
end
