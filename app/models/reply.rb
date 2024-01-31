# frozen_string_literal: true

class Reply < ApplicationRecord
  belongs_to :user
  belongs_to :tweet
  validates :content, presence: true, length: { maximum: 140 }
  has_many_attached :reply_images
end
