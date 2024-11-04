class AddCompoundIndexToPracticeSessions < ActiveRecord::Migration[7.0]
  disable_ddl_transaction!

  def change
    ActiveRecord::Base.connection.execute("SET lock_timeout TO '10s'")
    add_index :practice_sessions, [:user_id, :conflict_id], 
      algorithm: :concurrently
  end
end