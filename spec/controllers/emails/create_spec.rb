# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'POST emails', type: :request do
  subject(:api_request) do
    post(
      api_v1_emails_path,
      params: params,
      headers: headers,
      as: :json
    )
  end

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

  context 'when user asks for changing email' do
    context 'when the email is blank' do
      let(:params) { { email: nil} }

      it 'returns \'Email not found.\'' do
        expect(response).to have_http_status(:bad_request)
        expect(JSON.parse(response.body)['errors']).to eq(['Email not found or it is blank.'])
      end
    end

    context 'when an invalid email is entered' do
      let(:params) { { email: "WRONG_EMAIL"} }

      it 'returns \'email format is not valid\'' do
        expect(response).to have_http_status(:bad_request)
        expect(JSON.parse(response.body)['errors']).to eq(['Invalid email format.'])
      end
    end

    context 'when a valid email is entered' do
      let!(:user) do
        create(:user, email: "agustin@setaworkshop.com")
      end

      let!(:params) do
        {
          unconfirmed_email: "agustinvignolosotelo@gmail.com",
          email: "agustin@setaworkshop.com"
        }
      end

      it 'returns \'Email confirmation has been sent.\''do
        expect(response).to have_http_status(:ok)
        expect(JSON.parse(response.body)['messages']).to eq(['Confirmation email has been sent.'])
      end
    end

    context 'when there is no user with corresponding email' do
      let(:params) do
        {
          unconfirmed_email: Faker::Internet.email,
          email: Faker::Internet.email
        }
      end

      it 'returns \'Wrong credentials\'' do
        expect(response).to have_http_status(:bad_request)
        expect(JSON.parse(response.body)['errors']).to eq(['Wrong credentials.'])
      end
    end

  end
end
