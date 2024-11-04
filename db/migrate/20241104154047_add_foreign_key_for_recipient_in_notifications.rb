class AddForeignKeyForRecipientInNotifications < ActiveRecord::Migration[7.0]
  def change
    add_foreign_key :notifications, :users, column: :recipient_id, validate: false
  end
end