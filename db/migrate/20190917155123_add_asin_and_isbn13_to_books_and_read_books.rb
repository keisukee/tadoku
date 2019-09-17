class AddAsinAndIsbn13ToBooksAndReadBooks < ActiveRecord::Migration[5.2]
  def change
    add_column :books, :asin, :string
    add_column :read_books, :asin, :string
  end
end
