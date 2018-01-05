class MovieSerializer < ActiveModel::Serializer
  # attributes to be serialized
  attributes :id, :title, :tmdb_id, :poster_path,
    :runtime, :release_date, :created_at, :updated_at
  # model association
  has_many :genres
end
