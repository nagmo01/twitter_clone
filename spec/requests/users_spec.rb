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
      confirmed_at: Time.zone.today,
      tel: '1234567890',
      birthday: '20000101'
    } }
  end

  context 'when user is in registrations' do
    it '入力項目に問題がなければ、新規登録に成功すること' do
      expect do
        post user_registration_path, params: valid_attributes
      end.to change(User, :count).by(1)
    end

    it '入力項目に不備があれば、新規登録に失敗すること' do
      valid_attributes[:user][:userid] = ''
      expect do
        post user_registration_path, params: valid_attributes
      end.to change(User, :count).by(0)
    end
  end

  context 'when user is in sessions' do
    it 'ログインしてる時、ユーザーはTOPページにアクセスできること' do
      user = FactoryBot.create(:user)
      sign_in(user)
      get root_path
      expect(response).to have_http_status(:ok)
    end

    it 'ログインしていない時、TOPページにアクセスできず、別のページにリダイレクトされること' do
      get root_path
      expect(response).to have_http_status(:found)
    end
  end
end
