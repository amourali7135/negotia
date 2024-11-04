class AddConflict2ToNegotiations < ActiveRecord::Migration[7.0]
  disable_ddl_transaction!

  def change
    ActiveRecord::Base.connection.execute("SET lock_timeout TO '10s'")
    add_reference :negotiations, :conflict2, index: { algorithm: :concurrently }  # Note: no null: false here
  end
end