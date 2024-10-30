class AddConflictReferenceToIssues < ActiveRecord::Migration[7.0]
  disable_ddl_transaction!

  def change
    add_reference :issues, :conflict, null: false, index: { algorithm: :concurrently }
  end
end
