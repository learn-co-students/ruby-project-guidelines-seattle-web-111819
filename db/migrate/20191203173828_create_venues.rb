class CreateVenues < ActiveRecord::Migration[5.2]
  def change
    create_table :venues do |t|
      t.string :name
      t.string :street_address
      t.string :city 
      t.integer :zip_code
      t.integer :capacity 
    end 
  end
end
