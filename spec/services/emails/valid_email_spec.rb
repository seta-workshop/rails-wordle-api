# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'ValidEmail Service ', type: :service do
  subject(:service_call) { Users::ValidEmail.call(email: email) }

  let(:email) { Faker::Internet.email }

  before(:each){ service_call }

  context 'Checking if typed email is valid'do
    context 'if email is blank' do
      let(:email){ " " }
      it 'returns \'Email not found or it is blank.\'' do
        expect(service_call.errors).to eq(['Email not found or it is blank.'])
      end
    end

    context 'if email format is invalid' do
      let(:email) { "WRONG_EMAIL" }
      it 'returns \'Invalid email format.\''do
        expect(service_call.errors).to eq(['Invalid email format.'])
      end
    end

    context 'if email is valid' do
      it 'Valid email format, continues'do
        expect(service_call.messages).to eq(['Valid email format.'])
      end
    end

  end
end
