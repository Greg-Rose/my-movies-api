require 'rails_helper'

RSpec.describe Movie, type: :model do
  it { should have_many(:genres_movies).dependent(:destroy) }
  it { should have_many(:genres).through(:genres_movies) }
  it { should have_many(:my_movies).dependent(:destroy) }
  it { should have_many(:users).through(:my_movies) }

  it { should validate_presence_of(:title) }
  it { should validate_presence_of(:tmdb_id) }
  it { should validate_presence_of(:release_date) }
  it { should validate_presence_of(:runtime) }
  it { should validate_presence_of(:poster_path) }
end
