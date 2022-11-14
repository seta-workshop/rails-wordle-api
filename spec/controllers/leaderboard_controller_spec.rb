# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Api::V1::LeaderboardController, type: :request do
  subject(:api_request){ get(api_v1_leaderboard_index_path, params: params, headers: headers, as: :json)}

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
      "Authorization" => ("Bearer #{token}")
    }
  end

  before(:each) { api_request }

  context 'when user requests users leaderboard' do

    context 'when token is invalid' do
      let(:token) { 'Invalid Token' }
      it 'returns token is invalid or it expired' do
        expect(JSON.parse(response.body)['errors']).to eq(I18n.t('errors.standard_error'))
        expect(response).to have_http_status(:bad_request)
      end
    end

    context 'when token is valid' do
      it 'returns success' do
        expect(JSON.parse(response.body)['messages']).to eq(I18n.t('global.success'))
        expect(response).to have_http_status(:ok)
      end
    end

  end
end
