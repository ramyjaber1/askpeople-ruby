# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :inboxes, dependent: :destroy
  # has_many :messages,through: :inboxes,
  # has_many :message, dependent: :destroy
  acts_as_voter
end
