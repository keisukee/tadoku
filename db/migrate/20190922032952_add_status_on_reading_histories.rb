class AddStatusOnReadingHistories < ActiveRecord::Migration[5.2]
  def change
    add_column :reading_histories, :status, :integer
  end
end
