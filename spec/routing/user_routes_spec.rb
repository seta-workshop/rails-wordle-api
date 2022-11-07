# frozen_string_literal: true

require 'rails_helper'
RSpec.describe 'API::V1::UserController', type: :routing do
  context 'When user register route is called' do
    it 'routes to api/v1/users#create' do
      expect(post: 'api/v1/users').to route_to(
        controller: 'api/v1/users',
        action: 'create'
      )
    end
  end
end
