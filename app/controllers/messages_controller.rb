# frozen_string_literal: true

class MessagesController < ApplicationController
  before_action :authenticate_user!

  def index
    @my_messages = Message.my_messages(current_user)
  end

  def show
    @messages = Message.where(sender_id: current_user.id,
                              receiver_id: params[:id]).or(Message.where(
                                                             sender_id: params[:id], receiver_id: current_user.id
                                                           ))

    @receiver = User.find(params[:id])
  end

  def create
    @message = current_user.sent_messages.build(receiver_id: params[:id], content: params[:content])

    @message.save!

    redirect_back(fallback_location: root_path)
  end
end
