# frozen_string_literal: true

class HomeController < ApplicationController
  before_action :authenticate_user!
  def index
    @tweet = Tweet.new
    @tweets = Tweet.all.order(created_at: :desc).page(params[:page])
  end
end
