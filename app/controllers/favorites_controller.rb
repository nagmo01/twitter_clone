# frozen_string_literal: true

class FavoritesController < ApplicationController
  def create
    @favorite = Favorite.find_by(tweet_id: params[:id], user_id: current_user.id)
    if @favorite
      @favorite.destroy
    else
      @favorite = current_user.favorites.build(tweet_id: params[:id])
      @favorite.save!
    end
    redirect_back(fallback_location: root_path)
  end
end
