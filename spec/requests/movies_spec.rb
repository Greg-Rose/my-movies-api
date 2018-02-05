require 'rails_helper'

RSpec.describe 'Movies API', type: :request do
  let(:user) { create(:user) }
  # authorize request
  let(:headers) { valid_headers }

  describe 'GET /movies/discover' do
    # make HTTP get request before each example
    before do
      body = JSON.generate ({
        "page"=>1,
        "total_results"=>339733,
        "total_pages"=>16987,
        "results"=> []
      })
      response = mock_request(body)

      expect(HTTParty).to receive(:get).and_return(response)
      get '/movies/discover', params: {}, headers: headers
    end

    it 'returns movies' do
      expect(json).not_to be_empty
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  describe 'GET /movies/search' do
    # make HTTP get request before each example
    before do
      body = JSON.generate ({
        "page"=>1,
        "total_results"=>339733,
        "total_pages"=>16987,
        "results"=> []
      })
      response = mock_request(body)

      expect(HTTParty).to receive(:get).and_return(response)
      get '/movies/search?query=deadpool', params: {}, headers: headers
    end

    it 'returns movies matching search' do
      expect(json).not_to be_empty
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  describe 'GET /movies/find/:tmdb_id' do
    let!(:movie) { create(:movie, tmdb_id: 181808) }
    let!(:my_movie_watched) { create(:my_movie, user: user, movie: movie) }
    # make HTTP get request before each example
    before do
      # create fake response
      body = JSON.generate ({
        "title" => "Test",
        "id" => 181808
      })
      response = mock_request(body)

      expect(HTTParty).to receive(:get).and_return(response)
      get '/movies/find/181808', params: {}, headers: headers
    end

    it 'returns requested movie' do
      expect(json).not_to be_empty
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  describe 'GET /movies/popular' do
    # make HTTP get request before each example
    before do
      body = JSON.generate ({
        "page"=>1,
        "total_results"=>339733,
        "total_pages"=>16987,
        "results"=> []
      })
      response = mock_request(body)

      expect(HTTParty).to receive(:get).and_return(response)
      get '/movies/popular', params: {}, headers: headers
    end

    it 'returns movies' do
      expect(json).not_to be_empty
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end
end
