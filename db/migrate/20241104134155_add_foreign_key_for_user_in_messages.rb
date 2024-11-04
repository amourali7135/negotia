class AddForeignKeyForUserInMessages < ActiveRecord::Migration[7.0]
  def change
    add_foreign_key :messages, :users, on_delete: :cascade, validate: false
  end
end