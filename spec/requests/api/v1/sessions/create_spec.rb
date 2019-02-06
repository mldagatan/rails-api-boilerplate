require 'rails_helper'

describe 'POST api/v1/auth/sign_in' do
  let(:password) { 'password' }
  let(:token) do
    {
      '3eF_EIPtkMZxypH2fDjMJA' => {
        'token' => 'HnuMVWfbQCSRW_Hu8wLRh4-DW2aUP_ok7yd2yxMQ7Mw',
        'expiry' => 156_497_973_1
      }
    }
  end
  let(:user) { create(:user, password: password, tokens: token) }

  let(:params) do
    {
      user: {
        email: user.email,
        password: password
      }
    }
  end

  context 'when params is correct' do
    before do
      post user_session_path, params: params, as: :json
    end

    it 'returns success' do
      expect(response).to be_successful
    end

    it 'returns the user in json' do
      user_data = json[:data]

      expect(user_data[:id]).to eq(user.id)
      expect(user_data[:provider]).to eq(user.provider)
      expect(user_data[:uid]).to eq(user.uid)
      expect(user_data[:email]).to eq(user.email)
    end

    it 'returns a valid access token and a client' do
      token = response.header['access-token']
      client = response.header['client']

      expect(user.reload.valid_token?(token, client)).to eq true
    end
  end
end
