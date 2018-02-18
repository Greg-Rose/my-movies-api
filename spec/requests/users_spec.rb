require 'rails_helper'

RSpec.describe 'Users API', type: :request do
  # User signup test suite
  describe 'POST /sign_up' do
    let(:user) { build(:user) }
    let(:headers) { valid_headers.except('Authorization') }
    let(:valid_attributes) do
      attributes_for(:user, password_confirmation: user.password)
    end

    context 'when valid request' do
      before { post '/sign_up', params: valid_attributes.to_json, headers: headers }

      it 'creates a new user' do
        expect(response).to have_http_status(201)
      end

      it 'returns success message' do
        expect(json['message']).to match(/Account created successfully/)
      end

      it 'returns an authentication token' do
        expect(json['auth_token']).not_to be_nil
      end
    end

    context 'when invalid request' do
      before { post '/sign_up', params: {}, headers: headers }

      it 'does not create a new user' do
        expect(response).to have_http_status(422)
      end

      it 'returns failure message' do
        expect(json['message'])
          .to match(/Validation failed: Password can't be blank, First name can't be blank, Last name can't be blank, Email can't be blank, Password digest can't be blank/)
      end
    end
  end

  # User views account to edit
  describe 'GET /account' do
    let(:user) { create(:user) }
    let(:headers) { valid_headers }

    context 'when valid request' do
      before { get '/account', params: {}, headers: headers }

      it 'returns account info' do
        expect(json).not_to be_empty
        expect(json["email"]).to eq(user.email)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when invalid request' do
      before { get '/account', params: {}, headers: {} }

      it 'does not return account info' do
        expect(json["email"]).to be_nil
      end

      it 'returns failure message' do
        expect(json['message'])
          .to match('Missing token')
      end
    end
  end

  # User edits account
  describe 'PUT /account' do
    let(:user) { create(:user) }
    let(:headers) { valid_headers }

    context 'when valid request' do
      before { put '/account', params: { first_name: user.first_name,
                                         last_name: user.last_name,
                                         email: user.email, password: "newpass",
                                         password_confirmation: "newpass",
                                         current_password: user.password
                                       }.to_json, headers: headers }

      it 'returns account info' do
        expect(json["email"]).to eq(user.email)
        expect(json["message"]).to be nil
        expect(User.first.authenticate("newpass")).to_not be false
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when current password is invalid' do
      before { put '/account', params: { current_password: "wrong" }.to_json, headers: headers }

      it 'does not return account info' do
        expect(json["email"]).to be_nil
      end

      it 'returns failure message' do
        expect(json['message']).to eq(['Invalid credentials'])
      end
    end

    context 'when validation fails' do
      before { put '/account', params: { first_name: '',
                                         last_name: user.last_name,
                                         email: user.email, password: "test1",
                                         password_confirmation: "test2",
                                         current_password: user.password
                                       }.to_json, headers: headers }

      it 'does not return account info' do
        expect(json["email"]).to be_nil
      end

      it 'returns failure message' do
        expect(json['message']).to eq(["Password confirmation doesn't match Password", "First name can't be blank"])
      end
    end
  end
end
