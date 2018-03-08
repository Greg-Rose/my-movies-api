require 'rails_helper'

describe TMDB::Movie do
  describe "#discover" do

  end

  describe "#search" do

  end

  describe "#find" do

  end

  describe "#popular" do

  end

  describe "#genres" do
    results = nil

    before do
      body = JSON.generate ({
        "page"=>1,
        "total_results"=>25,
        "total_pages"=>2,
        "results"=> ["test"]
      })
      response = mock_request(body)

      expect(HTTParty).to receive(:get).and_return(response)
      results = TMDB::Movie.genres
    end

    it 'returns genres' do
      expect(results["page"]).to eq 1
      expect(results["total_pages"]).to eq 2
      expect(results["total_results"]).to eq 25
      expect(results["results"].first).to eq "test"
    end
  end
end
