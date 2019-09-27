class ChangeGenreColumnOnReadingHistories < ActiveRecord::Migration[5.2]
  def up
    change_column :reading_histories, :genre, 'integer USING CAST(column_name AS integer)'
  end

  def down
    change_column :reading_histories, :genre, :string
  end
end
