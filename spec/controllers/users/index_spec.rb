# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Api::V1::UsersController, type: :request do
  subject(:api_request){ get(api_v1_users_path, params: params, headers: headers, as: :json)}

  let!(:user)   { create(:user) }
  let(:token)   { jwt_encode(user_id: user.id) }
  let(:params) do
    {
      email: Faker::Internet.email,
      unconfirmed_email: Faker::Internet.email
    }
  end
  let(:headers) do
    {
      "Authorization" => ("Bearer " + token)
    }
  end

  def jwt_encode(payload, expires_at = 1.days.from_now)
    payload[:expires_at] = expires_at.to_i
    JWT.encode(payload, Rails.application.secret_key_base)
  end

  before(:each) { api_request }

  context 'When user requests users leaderboard' do

    context 'when token is invalid' do
      let(:token) { 'Invalid Token' }
      it 'returns token is invalid or it expired' do
        expect(JSON.parse(response.body)['errors']).to eq(I18n.t('errors.standard_error'))
        expect(response).to have_http_status(:bad_request)
      end
    end

    context 'when token is valid' do
      it 'returns token is invalid or it expired' do
        expect(JSON.parse(response.body)['messages']).to eq(I18n.t('global.success'))
        expect(response).to have_http_status(:ok)
      end
    end

  end
end
