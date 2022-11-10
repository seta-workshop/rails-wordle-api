# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Attempts::Create, type: :service do
  subject(:service_call) { described_class.call(match: match, params: params) }

  let(:user) { create(:user) }
  let(:word) { create(:word) }


  context '#call' do
    context 'when match mode is basic and word is not 5 chars long'do
    let(:match) { create(:match, user_id: user.id, word_id: word.id) }
    let(:params) { { word: 'not_valid'} }

      it 'returns \'Only 5 characters are supported in basic mode\'' do
        expect(service_call.errors).to eq(['Only 5 characters are supported in basic mode.'])
      end
    end

    context 'when match mode is scientific and word is not 7 chars long'do
      let(:match) { Match.create(mode: 'scientific', user_id: user.id, word_id: word.id) }
      let(:params) { { word: 'not_valid'} }

      it 'returns \'Only 7 characters are supported in scientific mode\'' do
        expect(service_call.errors).to eq(['Only 7 characters are supported in scientific mode.'])
      end
    end
  end

  context '#call benchmark' do
    it 'should perform under 50ms' do
      expect(service_call).to perform_under(50).ms
    end
  end
end
