class Genre < ApplicationRecord
  has_many :genres_movies, dependent: :destroy
  has_many :movies, through: :genres_movies

  validates_presence_of :name
end
