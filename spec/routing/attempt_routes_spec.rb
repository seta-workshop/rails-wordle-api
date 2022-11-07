# frozen_string_literal: true

require 'rails_helper'
RSpec.describe 'API::V1::AttemptsController', type: :routing do
  context 'When new attempt for todays match route is called' do
    it 'routes to api/v1/matches/attempts#create' do
      expect(post: 'api/v1/matches/1/attempts').to route_to(
        controller: 'api/v1/matches/attempts',
        match_id: '1',
        action: 'create'
      )
    end
  end
end
