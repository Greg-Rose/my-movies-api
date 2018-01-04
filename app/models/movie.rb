class Movie < ApplicationRecord
  has_many :genres_movies, dependent: :destroy
  has_many :genres, through: :genres_movies

  validates_presence_of :title, :tmdb_id, :release_date, :runtime, :poster_path
end
