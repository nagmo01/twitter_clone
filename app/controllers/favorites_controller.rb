# frozen_string_literal: true

class FavoritesController < ApplicationController
  before_action :authenticate_user!

  def create
    @favorite = Favorite.find_by(tweet_id: params[:id], user_id: current_user.id)

    begin
      ActiveRecord::Base.transaction do
        if @favorite
          @favorite.destroy
        else
          @favorite = current_user.favorites.build(tweet_id: params[:id])
          @favorite.save!

          tweet = Tweet.find(params[:id])
          send_notification(tweet, current_user)
        end
      end
    rescue StandardError
      flash[:alert] = 'いいねに失敗しました。'
    end

    redirect_back(fallback_location: root_path)
  end

  private

  def send_notification(tweet, current_user)
    @notification = current_user.active_notifications.build(visited_id: tweet.user.id, tweet_id: tweet.id,
                                                            action_type: 'favorite')
    @notification.save!
    NotificationMailer.notification_email(@notification).deliver unless current_user == tweet.user
  end
end
