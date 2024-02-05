# frozen_string_literal: true

class BookmarksController < ApplicationController
  before_action :authenticate_user!

  def index
    @bookmarks = current_user.bookmarks
  end

  def create
    @bookmark = current_user.bookmarks.find_by(tweet_id: params[:id])
    if @bookmark
      @bookmark.destroy
    else
      @bookmark = current_user.bookmarks.build(tweet_id: params[:id])
      @bookmark.save!
    end
    redirect_back(fallback_location: root_path)
  end
end
