# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Tweets', type: :request do
  describe 'GET /create' do
    it 'returns http success' do
      get '/tweets/create'
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET /destroy' do
    it 'returns http success' do
      get '/tweets/destroy'
      expect(response).to have_http_status(:success)
    end
  end
end
