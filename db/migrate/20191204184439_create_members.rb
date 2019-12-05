class CreateMembers < ActiveRecord::Migration[5.0]

  def change
    create_table :members do |t|
    t.string :name
    t.integer :years_experience
    end
  end
end
