# frozen_string_literal: true

class Tweet < ApplicationRecord
  has_many_attached :images
  belongs_to :user
  has_many :favorites, dependent: :destroy
  has_many :bookmarks, dependent: :destroy
  has_many :replies, dependent: :destroy
  validates :content, presence: true, length: { maximum: 140 }
end
