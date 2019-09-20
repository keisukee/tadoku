class CreateBooks < ActiveRecord::Migration[5.2]
  def change
    create_table :books do |t|
      t.string :title
      t.integer :length
      t.string :genre
      t.string :isbn
      t.string :level
      t.integer :pages

      t.timestamps
    end
  end
end
