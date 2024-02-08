# frozen_string_literal: true

class NotificationMailer < ApplicationMailer
  default from: 'railsecsite@gmail.com'

  def notification_email(user, notification)
    @user = user
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
    @url = 'http://localhost:3000'
    @url = 'https://hc-twitter-14d8e9cfa8c4.herokuapp.com' if Rails.env.production?

    mail(to: user.email, subject: "新しい#{@action}が届きました。")
  end
end
