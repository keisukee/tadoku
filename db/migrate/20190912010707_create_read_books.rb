class CreateReadBooks < ActiveRecord::Migration[5.2]
  def change
    create_table :read_books do |t|
      t.string :title
      t.integer :length
      t.string :genre
      t.string :isbn
      t.string :level
      t.integer :pages
      t.references :readable, polymorphic: true

      t.timestamps
    end
  end
end
