# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Create password service', type: :service do
  subject(:service_call) { Passwords::Create.call(params: params) }

  let(:params) { {email: email} }
  let!(:user)  { create(:user) }
  let(:email)  { user.email }

  before(:each) { service_call }

  context 'When password change is requested' do

    context 'Email is valid and user is present'do
      it 'returns \'email has been sent.\'' do
        expect(service_call.messages).to eq(['Email has been sent.'])
      end
    end

    context 'Email is blank' do
      let(:email) { "" }

      it 'returns \'Email not found or it is blank.\'' do
        expect(service_call.error).to eq('Email not found or it is blank.')
      end
    end

    context 'Email adress not found' do
      let(:email){ Faker::Internet.email }

      it 'returns \'Email not found or it is blank.\'' do
        expect(service_call.error).to eq('Email not found or it is blank.')
      end
    end

    context 'Email format is invalid' do
      let(:email) {"WRONG_EMAIL"}
      let!(:user)   { create(:user, email: Faker::Internet.email) }
      it 'reurns \'Invalid email format.\'' do
        expect(service_call.error).to eq('Invalid email format.')
      end
    end
  end
end
