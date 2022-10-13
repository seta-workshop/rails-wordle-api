# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'ValidEmail Service ', type: :service do
  subject(:service_call) { Users::ValidEmail.call(email: email) }

  let(:email) { Faker::Internet.email }

  before(:each){ service_call }

  context 'Checking if typed email is valid'do
    context 'if email is blank' do
      let(:email){ " " }
      it 'returns \'Email cannot be blank\'' do
        expect(service_call.errors).to eq(['Email cannot be blank'])
      end
    end

    context 'if email format is invalid' do
      let(:email) { "WRONG_EMAIL" }
      it 'returns \'Email format is invalid\''do
        expect(service_call.errors).to eq(['Email format is invalid'])
      end
    end

    context 'if email is valid' do
      it 'valid is true, continues'do
        expect(service_call.messages).to eq(['Email format is valid'])
      end
    end

  end
end
