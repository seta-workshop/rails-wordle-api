# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Create Match Service', type: :service do
  subject(:service_call) { Matches::Create.call(params: params, user: user) }
  let(:params) {  }
  let(:user) { create(:user) }
  let!(:word) { create(:word, kind: 'basic', value: 'siete') }

  context 'service is called' do
    context 'User has a match associated today' do
      let!(:match) { create(:match, mode:'basic', user: user, word: word) }

      it 'Returns current match from user' do
        expect(service_call.object.id).to eq(match.id)
      end
    end

    context 'User does not have a match associated today' do
      let(:user) { create(:user) }
      it 'Returns  a new match associated to user' do
        expect { service_call }.to change { Match.count }.by(1)
        expect(service_call.object.user_id).to eq(user.id)
      end
    end

    context 'User is not present' do
      let(:user) { }
      it 'Returns \'User not present\'' do
        expect(service_call.errors).to eq(['User not present'])
      end
    end
  end
end
