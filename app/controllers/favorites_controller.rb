# frozen_string_literal: true

class FavoritesController < ApplicationController
  before_action :authenticate_user!

  def create
    @favorite = Favorite.find_by(tweet_id: params[:id], user_id: current_user.id)
    if @favorite
      @favorite.destroy
    else
      @favorite = current_user.favorites.build(tweet_id: params[:id])
      @favorite.save!

      tweet = Tweet.find(params[:id])
      @notification = current_user.active_notifications.build(visited_id: tweet.user.id, tweet_id: params[:id],
                                                              action_type: 'favorite')
      @notification.save!

      NotificationMailer.notification_email(tweet.user, @notification).deliver unless current_user == tweet.user

    end
    redirect_back(fallback_location: root_path)
  end
end
