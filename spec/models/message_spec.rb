require 'rails_helper'

describe Message do
  describe "#not_found" do
    it 'returns "Sorry, record not found."' do
      expect(Message.not_found).to eq 'Sorry, record not found.'
    end
  end

  describe "#invalid_credentials" do
    it 'returns "Invalid credentials"' do
      expect(Message.invalid_credentials).to eq 'Invalid credentials'
    end
  end

  describe "#invalid_token" do
    it 'returns "Invalid token"' do
      expect(Message.invalid_token).to eq 'Invalid token'
    end
  end

  describe "#missing_token" do
    it 'returns "Missing token"' do
      expect(Message.missing_token).to eq 'Missing token'
    end
  end

  describe "#unauthorized" do
    it 'returns "Unauthorized request"' do
      expect(Message.unauthorized).to eq 'Unauthorized request'
    end
  end

  describe "#account_created" do
    it 'returns "Account created successfully"' do
      expect(Message.account_created).to eq 'Account created successfully'
    end
  end

  describe "#account_not_created" do
    it 'returns "Account could not be created"' do
      expect(Message.account_not_created).to eq 'Account could not be created'
    end
  end

  describe "#expired_token" do
    it 'returns "Sorry, your token has expired. Please login to continue."' do
      expect(Message.expired_token).to eq 'Sorry, your token has expired. Please login to continue.'
    end
  end
end
