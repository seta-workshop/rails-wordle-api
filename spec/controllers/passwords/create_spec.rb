# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'POST /passwords/forgot', type: :request do
  subject(:api_request) { post(forgot_api_v1_passwords_path, params: params, as: :json) }

  let(:email)  { Faker::Internet.free_email }
  let(:params) { { email: email } }
  let!(:user) { create(:user, email: email ) }

  before(:each) {
    allow(Passwords::Create).to receive(:call).and_return(result)

    api_request
  }

  context 'when asking for password change' do
    context 'when it is valid' do
      let(:result) { ServiceResult.new(messages:['Email has been sent.']) }

       it 'returns success' do
        expect(JSON.parse(response.body)['message']).to eq(['Email has been sent.'])
        expect(response).to have_http_status(:ok)
      end
    end

    context 'when it is invalid' do
      let(:result) { ServiceResult.new(errors:['Email address not found. Check and try again.']) }
      let(:params) { { email: 'WRONG_EMAIL' } }

      it 'returns an error' do
        expect(JSON.parse(response.body)['errors']).to eq(['Email address not found. Check and try again.'])
        expect(response).to have_http_status(:bad_request)
      end
    end
  end
end
