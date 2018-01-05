require 'rails_helper'

RSpec.describe 'My Movies API', type: :request do
  let(:user) { create(:user) }
  let!(:my_movies_watched) { create_list(:my_movie, 10, user: user) }
  let!(:my_movies_to_watch) { create_list(:my_movie, 5, user: user, watched: false, to_watch: true) }
  let(:my_movie_id) { my_movies.first.id }
  let(:watched_movies) { user.movies.watched }
  let(:movies_to_watch) { user.movies.to_watch }
  # authorize request
  let(:headers) { valid_headers }

  # Test suite for GET /my_watched_movies
  describe 'GET /my_watched_movies' do
    before { get '/my_watched_movies', params: {}, headers: headers }

    it 'returns my_movies marked as watched' do
      expect(json).not_to be_empty
      expect(json.size).to eq(10)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  # Test suite for GET /my_movies_to_watch
  describe 'GET /my_movies_to_watch' do
    before { get '/my_movies_to_watch', params: {}, headers: headers }

    it 'returns my_movies marked as to watch' do
      expect(json).not_to be_empty
      expect(json.size).to eq(5)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  # Test suite for POST /my_movies
  describe 'POST /my_movies' do
    let(:valid_attributes) do
      # send json payload
      { title: 'Movie Title Test', tmdb_id: 10000, release_date: "2017-12-13",
        runtime: 120, poster_path: "/path",
        genres: [{
          "id": 14,
          "name": "Fantasy"
        }],
        watched: false
      }.to_json
    end

    context 'when the request is valid' do
      before { post '/my_movies', params: valid_attributes, headers: headers }

      it 'creates a my_movie' do
        expect(user.my_movies.last.movie.title).to eq('Movie Title Test')
      end

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end

      it 'adds associated genre' do
        expect(Genre.count).to be 1
        expect(GenresMovie.count).to be 1
      end
    end

    context 'when the request is invalid' do
      let(:invalid_attributes) { { title: "Only Title" }.to_json }
      before { post '/my_movies', params: invalid_attributes, headers: headers }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a validation failure message' do
        expect(response.body)
          .to match(/Validation failed: Tmdb can't be blank, Release date can't be blank, Runtime can't be blank, Poster path can't be blank/)
      end
    end
  end

  # Test suite for PUT /my_movies/:id
  describe 'PUT /my_movies/:id' do
    context 'when marking as watched' do
      let!(:my_movie) { create(:my_movie, user: user, watched: false, to_watch: true) }
      let(:valid_attributes) { { watched: true }.to_json }
      before { put "/my_movies/#{my_movie.id}", params: valid_attributes, headers: headers }

      it 'updates the record' do
        expect(json["watched"]).to be true
        expect(json["to_watch"]).to be false
      end

      it 'returns status code 204' do
        expect(response).to have_http_status(202)
      end
    end

    context 'when marking as to watch' do
      let!(:my_movie) { create(:my_movie, user: user, watched: true, to_watch: false) }
      let(:valid_attributes) { { to_watch: true }.to_json }
      before { put "/my_movies/#{my_movie.id}", params: valid_attributes, headers: headers }

      it 'updates the record' do
        expect(json["watched"]).to be true
        expect(json["to_watch"]).to be true
      end

      it 'returns status code 204' do
        expect(response).to have_http_status(202)
      end
    end

    context 'when watched and removing to watch' do
      let!(:my_movie) { create(:my_movie, user: user, watched: true, to_watch: true) }
      let(:valid_attributes) { { to_watch: false }.to_json }
      before { put "/my_movies/#{my_movie.id}", params: valid_attributes, headers: headers }

      it 'updates the record' do
        expect(json["watched"]).to be true
        expect(json["to_watch"]).to be false
      end

      it 'returns status code 204' do
        expect(response).to have_http_status(202)
      end
    end

    context 'when to watch and removing watched' do
      let!(:my_movie) { create(:my_movie, user: user, watched: true, to_watch: true) }
      let(:valid_attributes) { { watched: false }.to_json }
      before { put "/my_movies/#{my_movie.id}", params: valid_attributes, headers: headers }

      it 'updates the record' do
        expect(json["watched"]).to be false
        expect(json["to_watch"]).to be true
      end

      it 'returns status code 204' do
        expect(response).to have_http_status(202)
      end
    end

    context 'when removing' do
      let!(:my_movie) { create(:my_movie, user: user, watched: true, to_watch: false) }
      let(:valid_attributes) { { watched: false }.to_json }
      before { put "/my_movies/#{my_movie.id}", params: valid_attributes, headers: headers }

      it 'updates the record' do
        expect(response.body).to be_empty
        expect(MyMovie.count).to eq(15)
      end

      it 'returns status code 204' do
        expect(response).to have_http_status(204)
      end
    end
  end
end
