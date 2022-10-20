# frozen_string_literal: true

RSpec.describe 'Word Model Spec', type: :model do
  subject(:word) { Word.new(kind: kind, value: value) }

  context 'When a new Word is created'do
    context 'Word kind is basic and length value is different than 5' do
      let(:kind)  { 'basic' }
      let(:value) { 'siet' }

      it 'Value \'basic\' kind of words must be only 5 characters long' do
        expect(word).to be_invalid
        expect(word.errors.first.full_message).to eq('Kind \'basic\' kind of words must be only 5 characters long')
      end
    end

    context 'Word kind is scientific and length valie is different than 7'do
      let(:kind)  { 'scientific' }
      let(:value) { 'dk' }

      it 'Value \'basic\' kind of words must be only 7 characters long' do
        expect(word).to be_invalid
        expect(word.errors.first.full_message).to eq('Kind \'scientific\' kind of words must be only 7 characters long')
      end
    end
  end
end
