# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'PUT /passwords/:token', type: :request do
  subject(:api_request) { put(password_path(token), params: params, as: :json)}

  let(:user)     { create(:user ) }
  let(:token)    { user.reset_password_token }
  let(:params)   { { password: password } }
  let(:password) { 'password' }

  context 'when user tries to access password update link' do
    context'when token is valid' do
      before(:each) do
        user.generate_password_token!
        allow(Passwords::Update).to receive(:call).and_return(result)
        api_request
      end

      let(:result) { ServiceResult.new(messages:['Password has been changed']) }
      it 'returns success and changes password' do
        expect(JSON.parse(response.body)['message']).to eq(['Password has been changed'])
        expect(response).to have_http_status(:ok)
      end
    end

    context 'when token is expired' do
      before(:each) do
        user.generate_password_token!
        user.reset_password_sent_at = Time.now-10.days
        user.save
        api_request
      end
      let(:result) { ServiceResult.new(errors:['Link not valid or expired. Try generating new link.']) }
      it 'returns an error' do
        expect(JSON.parse(response.body)['errors']).to eq(['Link not valid or expired. Try generating new link.'])
        expect(response).to have_http_status(:bad_request)
      end
    end
    context 'when the password is not present' do
      let(:password) {}
      let(:result) { ServiceResult.new(errors:['New password not present']) }
      before(:each) do
        user.generate_password_token!
        api_request
      end

      it 'returns an error' do
        expect(response).to have_http_status(:bad_request)
        expect(JSON.parse(response.body)['errors']).to eq(['New password not present'])
      end
    end
  end

  def jwt_encode(payload, expires_at = 1.days.from_now)
    payload[:expires_at] = expires_at.to_i
    JWT.encode(payload, Rails.application.secret_key_base)
  end
end
