require 'rails_helper'

describe 'POST api/v1/users/sign_in' do
  let(:email)    { 'test@test.dev' }
  let(:password) { 'somepassword' }

  let(:params) do
    {
      user: {
        email: email,
        password: password
      }
    }
  end

  describe 'POST create' do
    context 'when all fields are valid' do
      before do
        post user_registration_path, params: params, as: :json
      end

      it 'responds with success' do
        expect(response).to have_http_status(:success)
      end

      it 'creates a user' do
        expect(User.count).to eq(1)
      end

      it 'returns the user' do
        user = json[:data]

        expect(user[:email]).to eq(email)
      end
    end

    context 'when the email is incorrect' do
      let(:email) { 'invalidemail' }

      before do
        post user_registration_path, params: params, as: :json
      end

      it 'responds with 422' do
        expect(response.status).to eq(422)
      end

      it 'does not create a user' do
        expect(User.count).to eq(0)
      end
    end

    context 'when the password is invalid' do
      let(:password) { 'short' }

      before do
        post user_registration_path, params: params, as: :json
      end

      it 'responds with 422' do
        expect(response.status).to eq(422)
      end

      it 'does not create a user' do
        expect(User.count).to eq(0)
      end
    end
  end
end
