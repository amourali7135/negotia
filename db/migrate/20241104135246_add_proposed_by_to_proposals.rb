class AddProposedByToProposals < ActiveRecord::Migration[7.0]
  disable_ddl_transaction!

  def change
    ActiveRecord::Base.connection.execute("SET lock_timeout TO '10s'")
    add_reference :proposals, :proposed_by, null: false, index: { algorithm: :concurrently }
  end
end