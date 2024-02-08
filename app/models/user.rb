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
  has_many :bookmarks, dependent: :destroy
  has_many :retweets, dependent: :destroy
  has_many :sent_messages, foreign_key: 'sender_id', class_name: 'Message', inverse_of: 'sender', dependent: :destroy
  has_many :received_messages, foreign_key: 'receiver_id', class_name: 'Message', inverse_of: 'receiver',
                               dependent: :destroy
  has_many :following_relationship, foreign_key: 'following_id', class_name: 'Relationship', dependent: :destroy,
                                    inverse_of: 'following'
  has_many :followed_relationship, foreign_key: 'followed_id', class_name: 'Relationship', dependent: :destroy,
                                   inverse_of: 'followed'
  has_many :active_notifications, foreign_key: 'visitor_id', class_name: 'Notification', dependent: :destroy,
                                  inverse_of: 'visitor'
  has_many :passive_notifications, foreign_key: 'visited_id', class_name: 'Notification', dependent: :destroy,
                                   inverse_of: 'visited'

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
