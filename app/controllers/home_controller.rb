# frozen_string_literal: true

class HomeController < ApplicationController
  before_action :authenticate_user!
  def index
    @tweet = Tweet.new
    @tweets = Tweet.all.order(created_at: :desc).page(params[:page])
    @follower_tweets = follower_tweets.order(created_at: :desc).page(params[:page])
  end

  def show
    @user = User.find(current_user.id)
    @tweets = @user.tweets.order(created_at: :desc).page(params[:page])
    @favorites = @user.favorites.order(created_at: :desc).page(params[:page])
    @retweets = @user.retweets.order(created_at: :desc).page(params[:page])
  end

  private

  def follower_tweets
    followed_ids = current_user.following_relationship
    followed_ids = followed_ids.map(&:followed_id)
    Tweet.where(user_id: followed_ids)
  end
end
