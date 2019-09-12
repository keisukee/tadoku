class DeleteReadableOnBooks < ActiveRecord::Migration[5.2]
  def up
    change_table :books do |t|
      t.remove_references :readable, polymorphic: true
    end
  end

  def down
    change_table :books do |t|
      t.add_references :readable, polymorphic: true
    end
  end
end
