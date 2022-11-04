# frozen_string_literal: true

RSpec.describe 'Word Model Spec', type: :model do
  subject(:word) { Word.new(kind: kind, value: value) }

  before(:each) { word }

  context 'When a new Word is created'do
    context 'Word kind is basic and length value is different than 5' do
      let(:kind)  { 'basic' }
      let(:value) { 'siet' }

      it I18n.t('models.word.basic_length_error') do
        expect(word).to be_invalid
        expect(word.errors.first.full_message).to eq(I18n.t('models.word.basic_length_error'))
      end
    end

    context 'Word kind is scientific and length value is different than 7'do
      let(:kind)  { 'scientific' }
      let(:value) { 'dk' }

      it I18n.t('models.word.scientific_length_error') do
        expect(word).to be_invalid
        expect(word.errors.first.full_message).to eq(I18n.t('models.word.scientific_length_error'))
      end
    end
  end
end
