class CreatePlants < ActiveRecord::Migration[5.0]
  def change
    create_table :plants do |t|
      t.string :common_name
      t.integer :member_id
      t.integer :garden_id
      t.float :height
    end
  end
end
