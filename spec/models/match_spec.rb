# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Match model', type: :model do
  subject(:match) { Match.new }

  let(:word) { Word.create(kind:'basic', value:'siete')}
  let(:user) { create(:user) }

  context 'When a new match is created' do

    context 'When User is not referenced to the Match' do
      it 'returns \'User must exist\'' do
        match.word_id = word.id
        expect(match).to be_invalid
        expect(match.errors.first.full_message).to eq('User must exist')
      end
    end

    context 'When Word is not referenced to the Match' do
      it 'returns \'Word must exist\'' do
        match.user_id = user.id

        expect(match).to be_invalid
        expect(match.errors.first.full_message).to eq('Word must exist')
      end
    end

    context 'When mode is not included in modes list'do
      it 'returns error, its invalid' do
        match.user_id = user.id
        match.word_id = word.id
        expect(match).to be_invalid
      end
    end

  end
end
