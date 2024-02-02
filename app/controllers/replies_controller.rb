# frozen_string_literal: true

class RepliesController < ApplicationController
  def create
    @reply = current_user.replies.build(tweet_id: params[:id], content: params[:content])

    if @reply.save
      redirect_to tweets_path(params[:id]), notice: 'ツイートが成功しました。'
    else
      redirect_to tweets_path(params[:id]), alert: @reply.errors.full_messages.join(', ').to_s
    end
  end
end
