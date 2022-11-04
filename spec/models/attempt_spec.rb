# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Attempt model', type: :model do
  subject(:attempt) { Attempt.new }

  let(:user) { create(:user) }
  let(:word) { Word.create(kind: 'scientific', value: 'sieteee') }
  let(:match) { Match.create(mode:"basic", word_id: word.id, user_id: user.id) }
  context 'When a new attempt is created' do
    context 'User doesnt exist' do
      it 'returns a message regarding \'User must exist\'' do
        expect(attempt).to be_invalid
        expect(attempt.errors.first.full_message).to eq('User must exist')
      end
    end

    context 'Match doesnt exist' do
      it 'returns a message regarding \'Match must exist\'' do
        attempt.user_id = user.id
        expect(attempt).to be_invalid
        expect(attempt.errors.first.full_message).to eq('Match must exist')
      end
    end

    context 'Letter array doesnt exist' do
      it 'returns a message regarding the letters length \'Letters is too short (minimum is 5 characters)\'' do
        attempt.user_id = user.id
        attempt.match_id = match.id

        expect(attempt).to be_invalid
        expect(attempt.errors.first.full_message).to eq('Letters is too short (minimum is 5 characters)')
      end
    end

    context 'Letter colours array doesnt exist' do
      it 'returns a message regarding the letters colours length  \'Letters colours is too short (minimum is 5 characters)\'' do
        attempt.user_id = user.id
        attempt.match_id = match.id
        attempt.letters = ['s','i','e','t','e']
        expect(attempt).to be_invalid
        expect(attempt.errors.first.full_message).to eq('Letters colours is too short (minimum is 5 characters)')
      end
    end

  end
end
