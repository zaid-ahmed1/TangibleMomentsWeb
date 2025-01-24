class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable, :omniauthable

  has_one_attached :avatar
  has_person_name
  has_many :memories, dependent: :destroy

  has_many :notifications, as: :recipient, dependent: :destroy, class_name: "Noticed::Notification"
  has_many :notification_mentions, as: :record, dependent: :destroy, class_name: "Noticed::Event"
  has_many :services

  def generate_jwt
    payload = {
      sub: id, # Subject (user ID)
      email: email,
      exp: 24.hours.from_now.to_i # Token expiration time (24 hours)
    }

    secret_key = Rails.application.credentials.jwt_secret
    JWT.encode(payload, secret_key, 'HS256')
  end
end
