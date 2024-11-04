class ValidateSenderForeignKeyInNotifications < ActiveRecord::Migration[7.0]
  def change
    validate_foreign_key :notifications, :users, column: :sender_id
  end
end