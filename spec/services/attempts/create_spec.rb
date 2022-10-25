# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Attempt creation service', type: :service do
  subject(:service_call) { Attempts::Create.call(match: match, params: params) }

  let(:user) { create(:user) }
  let(:word) { create(:word) }


  context 'when service is called' do
    context 'when match mode is basic and word is not 5 chars long'do
    let(:match) { Match.create(mode: 'basic', user_id: user.id, word_id: word.id) }
    let(:params) { { word: 'not_valid'} }

      it 'returns \'Only 5 characters are supported in basic mode\'' do
        expect(service_call.errors).to eq(['Only 5 characters are supported in basic mode'])
      end
    end

    context 'when match mode is scientific and word is not 7 chars long'do
      let(:match) { Match.create(mode: 'scientific', user_id: user.id, word_id: word.id) }
      let(:params) { { word: 'not_valid'} }

      it 'returns \'Only 7 characters are supported in scientific mode\'' do
        expect(service_call.errors).to eq(['Only 7 characters are supported in scientific mode'])
      end
    end

    context 'when maximum attempts is reached'do
        let(:match) { Match.create(mode: 'basic', user_id: user.id, word_id: word.id) }
        let(:params) { { word: 'eeeee'} }

      it 'returns \'Max attempts reached\'' do
        for i in 0..7
          match.attempts.create!(
            user_id: match.user_id,
            letters: ['a','a','a','a','a'],
            letters_colours: ['a','a','a','a','a']
          )
          match.save!
        end
        expect(service_call.errors).to eq(['Max attempts reached'])
      end
    end
  end
end
