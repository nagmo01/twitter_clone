# frozen_string_literal: true

class RepliesController < ApplicationController
  def create
    @reply = Reply.new
    @reply.tweet_id = params[:id]
    @reply.content = params[:content]
    @reply.user_id = current_user.id

    if @reply.save
      redirect_to "/tweet/#{params[:id]}", notice: 'ツイートが成功しました。'
    else
      redirect_to "/tweet/#{params[:id]}", alert: @reply.errors.full_messages.join(', ').to_s
    end
  end
end
