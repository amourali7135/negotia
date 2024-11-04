class AddNegotiationToMessages < ActiveRecord::Migration[7.0]
  disable_ddl_transaction!

  def change
    ActiveRecord::Base.connection.execute("SET lock_timeout TO '10s'")
    add_reference :messages, :negotiation, null: false, index: { algorithm: :concurrently }
    add_index :messages, [:negotiation_id, :created_at], algorithm: :concurrently
  end
end