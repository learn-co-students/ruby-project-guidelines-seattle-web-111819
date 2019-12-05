class AddApiGameAttributesToGames < ActiveRecord::Migration[5.0]
  def change
    add_column :games, :igdb_rating, :float
    add_column :games, :igdb_rating_count, :integer
    add_column :games, :release_date, :string
  end
end
