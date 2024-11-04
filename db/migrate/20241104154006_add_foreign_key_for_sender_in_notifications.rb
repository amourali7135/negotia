class AddForeignKeyForSenderInNotifications < ActiveRecord::Migration[7.0]
  def change
    add_foreign_key :notifications, :users, column: :sender_id, validate: false
  end
end