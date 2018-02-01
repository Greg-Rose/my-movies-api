class Movie < ApplicationRecord
  has_many :genres_movies, dependent: :destroy
  has_many :genres, through: :genres_movies
  has_many :my_movies, dependent: :destroy
  has_many :users, through: :my_movies

  validates_presence_of :title, :tmdb_id, :release_date, :runtime, :poster_path
end
