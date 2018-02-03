class AddTmdbIdToGenres < ActiveRecord::Migration[5.1]
  def change
    add_column :genres, :tmdb_id, :integer
    TMDB::Movie.genres["genres"].each do |g|
      local_genre = Genre.find_or_initialize_by(name: g["name"])
      local_genre.tmdb_id = g["id"]
      local_genre.save
    end
  end
end
