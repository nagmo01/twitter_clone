# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :trackable, :lockable, :timeoutable,
         :confirmable,
         :omniauthable, omniauth_providers: [:github]

  validates :name, presence: true
  validates :tel, presence: true, unless: -> { uid.present? }
  validates :birthday, presence: true, unless: -> { uid.present? }

  def self.find_for_oauth(auth)
    user = User.where(uid: auth.uid, provider: auth.provider).first

    user ||= User.create!(
      provider: auth.provider,
      uid: auth.uid,
      name: auth.info.name,
      email: auth.info.email,
      password: Devise.friendly_token[0, 20]
    )

    user
  end
end
