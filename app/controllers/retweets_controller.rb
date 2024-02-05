# frozen_string_literal: true

class RetweetsController < ApplicationController
  before_action :authenticate_user!

  def create
    @retweet = current_user.retweets.find_by(tweet_id: params[:id])
    if @retweet
      @retweet.destroy
    else
      @retweet = current_user.retweets.build(tweet_id: params[:id])
      @retweet.save!
    end

    redirect_back(fallback_location: root_path)
  end
end
