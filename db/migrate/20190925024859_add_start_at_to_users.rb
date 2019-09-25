class AddStartAtToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :start_at, :datetime
    add_column :users, :introduction, :text
    add_column :users, :site_name, :string
    add_column :users, :site_url, :string
  end
end
