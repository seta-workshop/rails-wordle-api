# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Match model', type: :model do
  subject(:match) { Match.new }

  let(:word) { Word.create(kind:'basic', value:'siete')}
  let(:user) { create(:user) }

  context 'When a new match is created' do

    context 'when User is not referenced to the Match' do
      it 'returns \'User must exist\' as a message' do
        match.word_id = word.id
        expect(match).to be_invalid
        expect(match.errors.first.full_message).to eq('User must exist')
      end
    end

    context 'when Word is not referenced to the Match' do
      it 'returns \'Word must exist\' as a message' do
        match.user_id = user.id

        expect(match).to be_invalid
        expect(match.errors.first.full_message).to eq('Word must exist')
      end
    end

    context 'when mode is not included in modes list'do
      it 'returns that match its invalid as an error message' do
        match.user_id = user.id
        match.word_id = word.id
        expect(match).to be_invalid
      end
    end

    context 'when maximum attempts is reached'do
      let(:match) { create(:match, mode: 'basic', user: user, word: word) }

      before(:each) do
        6.times do
          match.attempts.create(
            user_id: match.user_id,
            letters: ['a','a','a','a','a'],
            letters_colours: ['a','a','a','a','a']
          )
        end
      end

      it 'returns max attempts count was reached as a message' do
        a = match.attempts.create(
          user_id: match.user_id,
          letters: ['a','a','a','a','a'],
          letters_colours: ['a','a','a','a','a']
        )

        # expect(a).to be_invalid
        expect(a.errors.full_messages).to eq(['Max attempts reached.'])
      end
    end

  end
end
