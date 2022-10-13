# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'ValidateEmailUpdate Service', type: :service do
  subject(:service_call) { Users::ValidateEmailUpdate.call(current_user: user, params: params) }

  let(:params) do
    {
      unconfirmed_email: Faker::Internet.email
    }
  end

  let!(:user) { create(:user, unconfirmed_email: nil) }
  let!(:help_user) { create(:user, email: "test@email.com", unconfirmed_email: nil) }

  before(:each) { service_call }

  context 'When user wants to apply for a new unconfirmed email' do
    context 'when unconfirmed email typed is equals to current email' do
      let(:params) do
        {
          unconfirmed_email: user.email
        }
      end
      it 'returns \'Current Email and New Email cannot be the same\'' do
        expect(service_call.errors).to eq(['Current Email and New Email cannot be the same'])
      end
    end

    context 'When the new Email is already in use' do
      let(:params) do
        {
          unconfirmed_email: help_user.email
        }
      end
      it 'returns \'Email already in use.\'' do
        expect(service_call.errors).to eq(['Email already in use.'])
      end
    end

    context 'new Email is blank' do
      let(:params) do
        { unconfirmed_email: " " }
      end

      it 'returns \'Email not found or is blank.\'' do
        expect(service_call.errors).to eq(['Email not found or is blank.'])
      end
    end

    context 'Everything is valid' do
      it 'returns \'Success\''do
        expect(service_call.messages).to eq(['Success'])
      end
    end
  end
end
