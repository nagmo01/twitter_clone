# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Users', type: :request do


  let(:valid_attributes) do
    { user: { 
      userid: 'tarou',
      username: 'tarou',
      email: 'test@example.com', 
      password: 'password', 
      password_confirmation: 'password',
      confirmed_at: Date.today,
      tel: '1234567890',
      birthday: '20000101'
    }}
  end

  context "registration" do
    it "入力項目に問題がなければ、新規登録に成功すること" do
      expect{
        post user_registration_path, params: valid_attributes
      }.to change(User,:count).by(1)
    end

    it "入力項目に不備があれば、新規登録に失敗すること" do
      valid_attributes[:user][:userid] = ""
      expect{
        post user_registration_path, params: valid_attributes
      }.to change(User,:count).by(0)
    end
  end

  context "sessions" do
    it "ログインしてる時、ユーザーはTOPページにアクセスできること" do
      user = FactoryBot.create(:user)
      sign_in(user)
      get root_path
      expect(response).to have_http_status(200)
    end

    it "ログインしていない時、TOPページにアクセスできず、別のページにリダイレクトされること" do
      get root_path
      expect(response).to have_http_status(302)
    end
  end


end
