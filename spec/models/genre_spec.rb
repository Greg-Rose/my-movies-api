require 'rails_helper'

RSpec.describe Genre, type: :model do
  it { should have_many(:genres_movies).dependent(:destroy) }
  it { should have_many(:movies).through(:genres_movies) }

  it { should validate_presence_of(:name) }
end
