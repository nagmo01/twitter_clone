# frozen_string_literal: true

class NotificationMailer < ApplicationMailer
  default from: 'railsecsite@gmail.com'

  def notification_email(notification)
    @user = notification.visited
    @notification = notification
    case notification.action_type
    when 'favorite'
      @action = 'いいね'
    when 'retweet'
      @action = 'リツイート'
    when 'follow'
      @action = 'フォロー'
    when 'reply'
      @action = 'リプライ'
    end
    @url = ENV['SITE_URL']

    mail(to: @user.email, subject: "新しい#{@action}が届きました。")
  end
end
