# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Update Email', type: :request do
  subject(:api_request) do
    put(
      email_path(token),
      as: :json
    )
  end

  let!(:user) { create(:user) }
  let!(:token)do
    user.generate_email_token!
    user.reset_email_token
  end

  before(:each) do
    api_request
  end

  context 'when user confirms email change via link' do
    context 'when user is not found or reset token is invalid' do
      let(:token) { "WRONG_TOKEN" }

      it 'returns that \'token is invalid or it expired\'' do
        expect(response).to have_http_status(:bad_request)
        expect(JSON.parse(response.body)['errors']).to eq(['The link is invalid or it\'s expired.'])
      end
    end
    context 'when token is valid' do

      it 'unconfirmed email siwtches to the main email' do
        expect(response).to have_http_status(:ok)
        expect(JSON.parse(response.body)['messages']).to eq(['Email updated successfully!'])
      end
    end

  end
end
