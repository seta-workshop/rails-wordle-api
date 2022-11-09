# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Api::V1::ApiController, type: :request do
  class FooController < Api::V1::ApiController
    skip_before_action :authenticate_request

    def bar; end

    def current_user
      OpenStruct.new(id: 1, email: 'user@email.com')
    end

  end

  describe 'exceptions' do
    subject { get('/bar', as: :json) }

    let!(:user)           { create(:user, id: user_id, email: user_email) }

    let(:user_id)         { 4 }
    let(:user_email)      { 'user@email.com' }

    before(:all) do
      Rails.application.routes.draw { match 'bar', to: 'foo#bar', via: :all }
    end

    before(:each) do
      allow_any_instance_of(FooController).to receive(:bar).and_raise(exception)
    end

    after(:all) do
      Rails.application.reload_routes!
    end

    context 'StandardError is raised' do
      let(:exception) { StandardError.new }

      it 'returns an error' do
        subject

        expect(response).to have_http_status(:bad_request)
        expect(JSON.parse(response.body)['errors']).to eq('We are sorry. Something unexpected failed.')
      end
    end

    context 'when ActiveRecord::RecordNotUnique is raised' do
      let(:exception) { ActiveRecord::RecordNotUnique.new }

      it 'returns an error' do
        subject

        expect(response).to have_http_status(:bad_request)
        expect(JSON.parse(response.body)['errors']).to eq('We are sorry. Something unexpected failed.')
      end
    end

    context 'when ActiveRecord::RecordInvalid is raised' do
      let(:record)    { create(:user) }
      let(:exception) { ActiveRecord::RecordInvalid.new(record) }

      before(:each) { record.errors.add(:base, 'record invalid') }

      it 'returns an error' do
        subject

        expect(response).to have_http_status(:bad_request)
        expect(JSON.parse(response.body)['errors']).to eq('record invalid')
      end
    end

    context 'when ActiveRecord::RecordNotSaved is raised' do
      let(:record)    { create(:user) }
      let(:exception) { ActiveRecord::RecordNotSaved.new(nil, record) }

      before(:each) { record.errors.add(:base, 'record not saved') }

      it 'returns an error' do
        subject

        expect(response).to have_http_status(:bad_request)
        expect(JSON.parse(response.body)['errors']).to eq('record not saved')

      end
    end

    context 'when ActionController::RoutingError is raised' do
      let(:exception) { ActionController::RoutingError.new('routing error') }

      it 'returns an error' do
        subject

        expect(response).to have_http_status(:bad_request)
        expect(JSON.parse(response.body)['errors']).to eq('routing error')
      end
    end

  end
end
