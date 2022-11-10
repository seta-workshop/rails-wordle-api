# frozen_string_literal: true

require'rails_helper'

RSpec.describe 'Update password service', type: :service do
  subject(:service_call) { Passwords::Update.call(params: params) }

  let!(:user)  {create(:user)}
  let(:password) { Faker::Internet.password }
  let(:params)do
    {
      email: Faker::Internet.email,
      password: password,
      token: user.reset_password_token
    }
   end

    context 'When token is invalid or expired'do
    before(:each) do
      user.generate_password_token!
      user.reset_password_sent_at = Time.now-10.days
      user.save!
      service_call
    end
    it 'returns \'Link has expired or it is invalid.\'' do
      expect(service_call.errors).to eq(['Link has expired or it is invalid.'])
    end
  end

  context 'When user wants to update its password' do
    before(:each) do
      user.generate_password_token!
      service_call
    end

    context 'When token is valid and new password is present' do
      it 'Returns \'Password has been changed.\''do
        expect(service_call.messages).to eq(['Password has been changed.'])
      end
    end

    context 'When new password is not present' do
      let(:password) { "" }
      it 'Returns \'New passwod is not found.\''do
        expect(service_call.errors).to eq(['New password not found.'])
      end
    end

  end
end
