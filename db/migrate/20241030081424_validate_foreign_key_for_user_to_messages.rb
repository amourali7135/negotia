class ValidateForeignKeyForUserToMessages < ActiveRecord::Migration[7.0]
  def change
    validate_foreign_key :messages, :users, column: :user_id
  end
end
