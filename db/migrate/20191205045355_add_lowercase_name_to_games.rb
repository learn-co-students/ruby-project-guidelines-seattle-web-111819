class AddLowercaseNameToGames < ActiveRecord::Migration[5.0]
  def change
    add_column :games, :lowercase_name, :string
  end
end
