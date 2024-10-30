class AddConflict1ReferenceToNegotiations < ActiveRecord::Migration[7.0]
  disable_ddl_transaction!
  def change
    add_reference :negotiations, :conflict1, null: false, index: {algorithm: :concurrently}
  end
end

