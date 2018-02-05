require 'rails_helper'

RSpec.describe 'Genres API', type: :request do
  let(:user) { create(:user) }
  let!(:genres) { create_list(:genre, 5) }
  # authorize request
  let(:headers) { valid_headers }

  # Test suite for GET /genres
  describe 'GET /genres' do
    before { get '/genres', params: {}, headers: headers }

    it 'returns all genres' do
      expect(json).not_to be_empty
      expect(json.size).to eq(5)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end
end
