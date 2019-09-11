class AddColumnsToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :words, :string
    add_column :users, :title, :string
  end
end
