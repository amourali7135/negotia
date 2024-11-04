class AddForeignKeyForUser1InNegotiations < ActiveRecord::Migration[7.0]
  def change
    add_foreign_key :negotiations, :users, column: :user1_id, validate: false
  end
end
