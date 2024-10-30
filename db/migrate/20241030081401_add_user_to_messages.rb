class AddUserToMessages < ActiveRecord::Migration[7.0]
  disable_ddl_transaction!

  def change
    add_reference :proposal_response, :proposal, null: false, index: {algorithm: :concurrently}
  end
end
