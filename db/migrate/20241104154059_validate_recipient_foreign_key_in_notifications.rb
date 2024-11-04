class ValidateRecipientForeignKeyInNotifications < ActiveRecord::Migration[7.0]
  def change
    validate_foreign_key :notifications, :users, column: :recipient_id
  end
end