# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'ChangeEmail Service', type: :service do
  subject(:service_call){ Users::ChangeEmail.call(params: params) }

  let(:user){ create(:user) }
  let(:params) do
    {
      token: user.reset_email_token
    }
  end

  before(:each) do
    user.generate_email_token!
  end

  context 'When user wants to switch its email to unconfirmed mail'do
    context 'Token is valid'do
      it 'returns \'Email updated successfully!\'' do
        expect(service_call.messages).to eq(['Email updated successfully!'])
      end
    end

    context 'The link is invalid' do
      before(:each) do
        user.generate_email_token!
        user.reset_email_token = Time.now-10.days
      end
      it 'returns \'The link is invalid or it\'s expired.' do
        expect(service_call.errors).to eq(['The link is invalid or it\'s expired.'])
      end
    end

  end
end
