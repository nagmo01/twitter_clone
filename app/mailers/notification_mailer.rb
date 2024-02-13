# frozen_string_literal: true

class NotificationMailer < ApplicationMailer
  default from: 'railsecsite@gmail.com'
  ACTION_TYPE_MAPPING = {
    'favorite' => 'いいね',
    'retweet' => 'リツイート',
    'follow' => 'フォロー',
    'reply' => 'リプライ'
  }.freeze

  def notification_email(notification)
    @user = notification.visited
    @notification = notification

    @action = ACTION_TYPE_MAPPING[notification.action_type]

    @url = ENV['SITE_URL']

    mail(to: @user.email, subject: "新しい#{@action}が届きました。")
  end
end
