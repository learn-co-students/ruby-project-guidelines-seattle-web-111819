class CreateGardens < ActiveRecord::Migration[5.0]
  def change
    create_table :gardens do |t|
      t.string :name
      t.string :location
    end
  end
end
