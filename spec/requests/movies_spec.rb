require 'rails_helper'

RSpec.describe 'Movies API', type: :request do
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
      get '/movies/discover'
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
      get '/movies/search?query=deadpool'
    end

    it 'returns movies matching search' do
      expect(json).not_to be_empty
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  describe 'GET /movies/find/:tmdb_id' do
    # make HTTP get request before each example
    before do
      # create fake response
      body = JSON.generate ({
        "title" => "Test"
      })
      response = mock_request(body)

      expect(HTTParty).to receive(:get).and_return(response)
      get '/movies/find/181808'
    end

    it 'returns requested movie' do
      expect(json).not_to be_empty
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end
end
