# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'POST /auth/login', type: :request do
  subject(:api_request) do
     post(
      api_v1_auth_login_path(params: params),
      as: :json
    )
  end

  let(:params) do
    { email: email, password: password }
  end

  let(:email)    { 'agustin@setaworkshop.com' }
  let(:password) { 'password' }

  let!(:user) { create(:user, email: email, password: password) }

  before(:each) { api_request }

  context 'when user is logging in' do
    context 'when credentials are valid' do
      it '\'returns JWT token\'' do
        expect(response).to have_http_status(:ok)
      end
    end
    context 'when credentials are invalid' do
      let(:params) do
        { email: 'WRONG_EMAIL', password: password }
      end

      it 'returns an error' do
        expect(response).to have_http_status(:unauthorized)
      end
    end
  end
end
