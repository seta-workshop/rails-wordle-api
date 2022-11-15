# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Leaderboard::Leaderboard, type: :service do
  subject(:service_call) { described_class.call }

  context 'when user asks for leaderboard table' do
    context 'when table is ordered correctly' do
      let!(:user) { create(:user, username: 'test', wins: 10) }
      let!(:user1) { create(:user, username: 'test1', wins: 10) }
      let!(:user2) { create(:user, username: 'test2', wins: 10) }
      it 'returns leaderboard table in descending order and success message' do
        expect(is_ordered?(leaderboard: service_call.object[:leaderboard])).to be(true)
        expect(service_call.messages).to eq('Success.')
      end
    end

    context 'when there are no users on the podium yet' do
      it 'returns an error' do
        expect(service_call.errors).to eq(['There are no current users yet!'])
      end
    end
  end

  private

  def is_ordered?(leaderboard: )
    ret = true
    max = 999999
    leaderboard.each do |u|
      if u.wins <= max
        max = u.wins
      elsif
        ret = false
      end
    end

    ret
  end
end
