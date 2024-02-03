# frozen_string_literal: true

class RetweetsController < ApplicationController
  def create
    @retweet = Retweet.find_by(tweet_id: params[:id], user_id: current_user.id)
    if @retweet
      @retweet.destroy
    else
      @retweet = current_user.retweets.build(tweet_id: params[:id])
      @retweet.save!
    end

    redirect_back(fallback_location: root_path)
  end
end
