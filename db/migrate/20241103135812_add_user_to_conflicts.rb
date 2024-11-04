class AddUserToConflicts < ActiveRecord::Migration[7.0]
  disable_ddl_transaction!

  def change
    ActiveRecord::Base.connection.execute("SET lock_timeout TO '10s'")
    # Ensure `user` is singular here
    add_reference :conflicts, :user, null: false, index: { algorithm: :concurrently }
  end
end

