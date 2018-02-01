class CreateGenresMovies < ActiveRecord::Migration[5.1]
  def change
    create_table :genres_movies do |t|
      t.belongs_to :genre, foreign_key: true
      t.belongs_to :movie, foreign_key: true

      t.timestamps
    end
  end
end
