# frozen_string_literal: true

class RelationshipsController < ApplicationController
  before_action :authenticate_user!

  def create
    # 自分自身に対してフォローを押した場合フォローリクエストを処理しない。
    user = User.find(params[:id])
    return redirect_back(fallback_location: root_path) if user == current_user

    begin
      @relationship = current_user.following_relationship.find_by(followed_id: params[:id])

      ActiveRecord::Base.transaction do
        if @relationship
          @relationship.destroy

        else
          @relationship = current_user.following_relationship.build(followed_id: params[:id])
          @relationship.save!

          @notification = current_user.active_notifications.build(visited_id: params[:id], action_type: 'follow')
          @notification.save!
          NotificationMailer.notification_email(@notification).deliver
        end
      end
    rescue StandardError
      flash[:alert] = 'フォローに失敗しました。'
    end

    redirect_back(fallback_location: root_path)
  end
end
