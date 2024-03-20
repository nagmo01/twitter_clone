# frozen_string_literal: true

class TweetsController < ApplicationController
  before_action :authenticate_user!

  def new; end

  def create
    @tweet = Tweet.new
    @tweet.content = params[:content]
    @tweet.user_id = params[:id]
    @tweet.images = params[:images]

    if @tweet.images.size > 4
      redirect_to root_path, notice: '画像を４枚までにしてください。'
    elsif @tweet.save
      redirect_to root_path, notice: 'ツイートが成功しました。'
    else
      redirect_to root_path, alert: @tweet.errors.full_messages.join(', ').to_s

    end
  end

  def show
    @tweet = Tweet.find(params[:id])
    @replies = @tweet.replies.order(created_at: :asc).page(params[:page])
  end

  def destroy; end
end
