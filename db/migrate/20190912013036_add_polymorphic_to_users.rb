class AddPolymorphicToUsers < ActiveRecord::Migration[5.2]
  def change
    add_reference :books, :readable, polymorphic: true
  end
end
