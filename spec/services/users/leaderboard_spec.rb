# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Users::Leaderboard, type: :service do
  subject(:service_call) { Users::Leaderboard.call() }

  before(:each) { service_call }

  context 'When user asks for leaderboard table' do
    it 'returns leaderboard table and success message' do
      expect(service_call.messages).to eq(I18n.t('global.success'))
    end
  end
end
