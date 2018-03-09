class GenreSerializer < ActiveModel::Serializer
  # attributes to be serialized
  attributes :id, :name, :tmdb_id, :created_at, :updated_at
end
