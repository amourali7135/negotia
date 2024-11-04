class AddSenderToNotifications < ActiveRecord::Migration[7.0]
  disable_ddl_transaction!

  def change
    ActiveRecord::Base.connection.execute("SET lock_timeout TO '10s'")
    add_reference :notifications, :sender, null: false, index: { algorithm: :concurrently }
    add_index :notifications, [:sender_id, :created_at], 
      algorithm: :concurrently
  end
end