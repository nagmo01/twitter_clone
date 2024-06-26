# frozen_string_literal: true

class HomeController < ApplicationController
  before_action :authenticate_user!
  def index
    @user = User.find(current_user.id)
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
    user = User.find(current_user.id)
    @relationship = user.following_relationship
    @relationship = @relationship.map(&:followed_id)
    Tweet.where(user_id: @relationship)
  end
end
