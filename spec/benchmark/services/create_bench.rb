# frozen_string_literal: true

require 'rails_benchmark_helper'

RSpec.describe Attempts::Create, type: :benchmark do
  subject(:service_call) { described_class.call(match: match, params: params) }

  let(:user) { User.find(rand(1..1000)) }
  let(:word) { create(:word) }
  let(:match) { create(:match, user_id: user.id, word_id: word.id) }
  let(:params) { { word: 'abcde'} }

  context '#call benchmark' do

    context 'when the user makes the first failed attempt' do

      context 'Timing' do
        it 'performs under 1ms' do
          expect { service_call }.to perform_under(1).ms.warmup(2)
        end
      end

      context 'Iterations' do
        it 'performs at least 10000 iterations' do
          expect { service_call }.to perform_at_least(10000).ips
        end
      end

      # Complexity matcher, doesnt apply to this benchmark
      # service.call complexity is not related with the size of the input

      # context 'Complexity' do
      #   it 'performs linearly' do
      #     expect { service_call }.to perform_power {}
      #   end
      # end

      context 'Alocation' do
        it 'allocates at sum 300KBytes' do
          expect { service_call }.to perform_allocation(300000).bytes
        end

        it 'allocates at most 3 ServiceResults' do
          expect { service_call }.to perform_allocation({ServiceResult => 3}).objects.and_retain(3)
        end
      end
    end

    context 'when the user already lost' do
      let(:match) { create(:match, user_id: user.id, word_id: word.id, status: :lose) }

      context 'Allocation' do
        it 'allocates at most 1 ServiceResult' do
          expect { service_call }.to perform_allocation({ServiceResult => 1}).objects
        end
      end
    end
  end

  context '#call comparisons' do
    it 'is faster than the candidate' do
      expect { service_call }.to perform_faster_than { Attempts::CreateCandidate.call(match: match, params: params) }
    end
  end
end
