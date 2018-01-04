class CreateMovies < ActiveRecord::Migration[5.1]
  def change
    create_table :movies do |t|
      t.string :title
      t.integer :tmdb_id
      t.datetime :release_date
      t.integer :runtime
      t.string :poster_path

      t.timestamps
    end
  end
end
