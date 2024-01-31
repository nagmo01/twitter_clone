# frozen_string_literal: true

module Users
  class RegistrationsController < Devise::RegistrationsController
    before_action :configure_sign_up_params, only: [:create]
    before_action :configure_account_update_params, only: [:update]

    def create
      super
      # @user = User.find(current_user.id)
      # unless @user.image.attached?
      # @user.image.attach(io: File.open(Rails.root.join('app/assets/images/cart.jpg')), filename: 'cart.jpg')
      # end
      # @user.update!

      @users = User.all
    end

    def update
      super
      @users = User.all
    end

    protected

    def update_resource(resource, params)
      resource.update_without_password(params)
    end

    def configure_sign_up_params
      devise_parameter_sanitizer.permit(:sign_up, keys: %i[userid tel birthday])
    end

    def configure_account_update_params
      devise_parameter_sanitizer.permit(:account_update,
                                        keys: %i[userid tel birthday username avatar header_image place website
                                                 description])
      return if account_update_params[:avatar].blank?

      resource.avatar.attach(account_update_params[:avatar])

      return if account_update_params[:header_image].blank?

      resource.avatar.attach(account_update_params[:header_image])
    end
  end
end
