class AddForeignKeyForUser1ToNegotiations < ActiveRecord::Migration[7.0]
  def change
    add_foreign_key :negotiations, :users, column: :user1_id
  end
end
