# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'API::V1::PasswordsController', type: :routing do
  context 'When asking for password change route' do
    it 'routes to api/v1/passwords#create' do
      expect(post: 'api/v1/passwords/forgot').to route_to(
        controller: 'api/v1/passwords',
        action: 'create'
      )
    end
  end

  context 'When updating password route' do
    it 'routes to api/v1/passwords#update' do
      expect(patch: 'api/v1/passwords/token').to route_to(
        controller: 'api/v1/passwords',
        token: 'token',
        action: 'update'
      )
    end
  end

end
