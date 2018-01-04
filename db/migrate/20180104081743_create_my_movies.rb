class CreateMyMovies < ActiveRecord::Migration[5.1]
  def change
    create_table :my_movies do |t|
      t.belongs_to :user, foreign_key: true
      t.belongs_to :movie, foreign_key: true
      t.boolean :watched
      t.boolean :to_watch

      t.timestamps
    end
  end
end
