
require 'rails_helper'
RSpec.describe 'API::V1::EmailsController', type: :routing do
  context 'When asking for email change route' do
    it 'routes to api/v1/emails#create' do
      expect(post: 'api/v1/emails').to route_to(
        controller: 'api/v1/emails',
        action: 'create'
      )
    end
  end

  context 'When updating for email update route' do
    it 'routes to api/v1/emails#update' do
      expect(patch: 'api/v1/emails/token').to route_to(
        controller: 'api/v1/emails',
        action: 'update',
        token: "token"
      )
    end
  end
end
