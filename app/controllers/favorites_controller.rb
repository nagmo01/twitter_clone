# frozen_string_literal: true

class FavoritesController < ApplicationController
  def create
    @favorite = Favorite.where(tweet_id: params[:id], user_id: current_user.id).first
    if @favorite
      @favorite.destroy
    else
      @favorite = Favorite.new
      @favorite.user_id = current_user.id
      @favorite.tweet_id = params[:id]
      @favorite.save!
    end
    redirect_back(fallback_location: root_path)
  end
end
