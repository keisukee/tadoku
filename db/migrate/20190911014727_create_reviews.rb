class CreateReviews < ActiveRecord::Migration[5.2]
  def change
    create_table :reviews do |t|
      t.string :title
      t.text :content
      t.decimal :stars, precision: 2, scale: 1

      t.timestamps
    end
  end
end
