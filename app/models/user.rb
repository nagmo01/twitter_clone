# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :trackable, :lockable, :timeoutable,
         :confirmable,
         :omniauthable, omniauth_providers: [:github]

  validates :userid, presence: true
  validates :tel, presence: true, unless: -> { uid.present? }
  validates :birthday, presence: true, unless: -> { uid.present? }

  has_one_attached :header_image
  has_one_attached :avatar
  has_many :tweets, dependent: :destroy
  has_many :replies, dependent: :destroy
  has_many :favorites, dependent: :destroy

  def self.find_for_oauth(auth)
    user = User.where(uid: auth.uid, provider: auth.provider).first

    user ||= User.create!(
      provider: auth.provider,
      uid: auth.uid,
      username: auth.info.name,
      userid: auth.info.nickname,
      email: auth.info.email,
      password: Devise.friendly_token[0, 20]
    )

    user.skip_confirmation!

    user
  end
end
