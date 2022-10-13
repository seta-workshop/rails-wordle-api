# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'EmailUpdate Service', type: :service do
  subject(:service_call) { Users::EmailUpdate.call(params: params) }

  let!(:user)  { create(:user) }
  let(:params) do
    {
      email: user.email,
      unconfirmed_email: user.unconfirmed_email
    }
  end
  let(:email) { Faker::Internet.email }
  before(:each){ service_call }

  context 'User wants to change to a new unconfirmed email'do
    context 'Unconfirmed email is blank'do
      let(:params)do
        {
          email: user.email,
          unconfirmed_email: " "
        }
      end
      it 'returns \'Email cannot be blank\'' do
        expect(service_call.errors).to eq(['Email cannot be blank'])
      end
    end

    context 'Email is blank'do
      let(:params)do
        {
          email: " ",
          unconfirmed_email: user.unconfirmed_email
        }
      end
      it 'returns \'Email cannot be blank\'' do
        expect(service_call.errors).to eq(['Email cannot be blank'])
      end
    end

    context 'Unconfirmed email is invalid'do
    let(:params)do
    {
      email: user.email,
      unconfirmed_email: "WRONG_EMAIL"
    }
  end
      it 'returns \'Email format is invalid\'' do
        expect(service_call.errors).to eq(['Email format is invalid'])
      end
    end

    context 'Email is invalid'do
    let(:params)do
    {
      email: "WRONG_EMAIL",
      unconfirmed_email: user.unconfirmed_email
    }
  end
      it 'returns \'Email format is invalid\'' do
        expect(service_call.errors).to eq(['Email format is invalid'])
      end
    end

    context 'Wrong current email, user is not found' do
      let(:params)do
      {
        email: Faker::Internet.email,
        unconfirmed_email: user.unconfirmed_email
      }
    end
      it 'returns \'Wrong credentials\'' do
        expect(service_call.errors).to eq(['Wrong credentials'])
      end
    end

    context 'Credentials and new Unconfirmed email are valid'do
      it 'returns \'Email confirmation has been sent.\'' do
        expect(service_call.messages).to eq(['Email confirmation has been sent.'])
      end
    end

  end
end
