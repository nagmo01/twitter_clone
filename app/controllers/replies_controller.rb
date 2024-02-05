# frozen_string_literal: true

class RepliesController < ApplicationController
  before_action :authenticate_user!

  def create
    @reply = Reply.new
    @reply = current_user.replies.build(tweet_id: params[:id], content: params[:content])

    if @reply.save
      redirect_to "/tweet/#{params[:id]}", notice: 'ツイートが成功しました。'
    else
      redirect_to "/tweet/#{params[:id]}", alert: @reply.errors.full_messages.join(', ').to_s
    end
  end
end
