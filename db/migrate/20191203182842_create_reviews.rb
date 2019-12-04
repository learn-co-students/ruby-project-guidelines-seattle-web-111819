class CreateReviews < ActiveRecord::Migration[5.0]
  def change
    create_table :reviews do |t|
      t.string :review_text
      t.integer :rating
      t.integer :user_id
    end
  end
end
