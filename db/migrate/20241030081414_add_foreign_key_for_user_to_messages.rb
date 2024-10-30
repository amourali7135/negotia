class AddForeignKeyForUserToMessages < ActiveRecord::Migration[7.0]
  def change
    add_foreign_key :messages, :users, column: :user_id, validate: false
  end
end
