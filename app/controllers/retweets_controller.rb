# frozen_string_literal: true

class RetweetsController < ApplicationController
  before_action :authenticate_user!

  def create
    @retweet = current_user.retweets.find_by(tweet_id: params[:id])

    begin
      ActiveRecord::Base.transaction do
        if @retweet
          @retweet.destroy
        else
          @retweet = current_user.retweets.build(tweet_id: params[:id])
          @retweet.save!

          tweet = Tweet.find(params[:id])
          send_notification(tweet, current_user)
        end
      end
    rescue StandardError
      flash[:notice] = 'リツイートに失敗しました。'
    end

    redirect_back(fallback_location: root_path)
  end

  private

  def send_notification(tweet, current_user)
    @notification = current_user.active_notifications.build(visited_id: tweet.user.id, tweet_id: tweet.id,
                                                            action_type: 'retweet')
    @notification.save!
    NotificationMailer.notification_email(@notification).deliver unless current_user == tweet.user
  end
end
