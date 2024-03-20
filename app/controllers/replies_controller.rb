# frozen_string_literal: true

class RepliesController < ApplicationController
  before_action :authenticate_user!

  def create
    @reply = current_user.replies.build(tweet_id: params[:id], content: params[:content])

    begin
      ActiveRecord::Base.transaction do
        if @reply.save
          # 通知の処理
          tweet = Tweet.find(params[:id])

          send_notification(tweet, current_user, @reply)

          redirect_to replies_path(params[:id]), notice: 'ツイートが成功しました。'
        else
          redirect_to replies_path(params[:id]), alert: @reply.errors.full_messages.join(', ').to_s
        end
      end
    rescue StandardError
      redirect_to replies_path(params[:id]), alert: '返信に失敗しました。'
    end
  end

  private

  def send_notification(tweet, current_user, reply)
    @notification = current_user.active_notifications.build(visited_id: tweet.user.id, tweet_id: tweet.id,
                                                            reply_id: reply.id, action_type: 'reply')
    @notification.save!
    NotificationMailer.notification_email(@notification).deliver unless current_user == tweet.user
  end
end
