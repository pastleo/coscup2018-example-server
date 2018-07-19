# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :payments, dependent: :destroy

  has_many :user_missions, dependent: :destroy
  has_many :missions, through: :user_missions

  validates :username, uniqueness: true

  private

  def email_required?
    false
  end
end
