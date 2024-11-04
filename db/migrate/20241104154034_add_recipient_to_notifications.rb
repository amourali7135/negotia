class AddRecipientToNotifications < ActiveRecord::Migration[7.0]
  disable_ddl_transaction!

  def change
    ActiveRecord::Base.connection.execute("SET lock_timeout TO '10s'")
    add_reference :notifications, :recipient, null: false, index: { algorithm: :concurrently }
    add_index :notifications, [:recipient_id, :status], 
      algorithm: :concurrently
  end
end