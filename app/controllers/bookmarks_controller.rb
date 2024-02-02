# frozen_string_literal: true

class BookmarksController < ApplicationController
  def index
    @bookmarks = current_user.bookmarks
  end

  def create
    @bookmark = Bookmark.find_by(tweet_id: params[:id], user_id: current_user.id)
    if @bookmark
      @bookmark.destroy
    else
      @bookmark = current_user.bookmarks.build(tweet_id: params[:id])
      @bookmark.save!
    end
    redirect_back(fallback_location: root_path)
  end
end
