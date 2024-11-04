class AddConflict1ToNegotiations < ActiveRecord::Migration[7.0]
  disable_ddl_transaction!
  def change
    ActiveRecord::Base.connection.execute("SET lock_timeout TO '10s'")
    add_reference :negotiations, :conflict1, null: false, index: {algorithm: :concurrently}
  end
end

