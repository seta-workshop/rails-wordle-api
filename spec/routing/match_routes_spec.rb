# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'API::V1::MatchesController', type: :routing do
  context 'When todays match route is called' do
    it 'routes to api/v1/matches#create' do
      expect(post: 'api/v1/matches').to route_to(
        controller: 'api/v1/matches',
        action: 'create'
      )
    end
  end
end
