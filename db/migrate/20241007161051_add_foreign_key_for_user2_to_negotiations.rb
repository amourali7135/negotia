class AddForeignKeyForUser2ToNegotiations < ActiveRecord::Migration[7.0]
  def change
    add_foreign_key :negotiations, :users, column: :user2_id, validate: false
  end
end
