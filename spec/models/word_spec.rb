# frozen_string_literal: true

RSpec.describe 'Word Model Spec', type: :model do
  subject(:word) { Word.new(kind: kind, value: value) }

  before(:each) { word }

  context 'When a new Word is created'do
    context ' when Word kind is basic and length value is different than 5' do
      let(:kind)  { 'basic' }
      let(:value) { 'siet' }

      it 'returns a message regarding the match word kind value length' do
        expect(word).to be_invalid
        expect(word.errors.first.full_message).to eq('Basic kind of words must be only 5 characters long.')
      end
    end

    context 'when word kind is scientific and length value is different than 7'do
      let(:kind)  { 'scientific' }
      let(:value) { 'dk' }

      it 'returns a message regarding the match word kind value length' do
        expect(word).to be_invalid
        expect(word.errors.first.full_message).to eq('Scientific kind of words must be only 7 characters long.')
      end
    end
  end
end
