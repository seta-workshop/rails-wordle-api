# frozen_string_literal: true

require 'rails_heper'

RSpec.describe 'Attempt creation service', type: :service do
  subject(:service_call) { Attempts::Create.call(params: params, user: user) }

  let(:user) { create(:user) }
  let(:params) { { words: Faker::Lorem.characters(number: 5)} }

  context 'when service is called' do
    context ''do
      it ' ' do

      end
    end

  end
end
