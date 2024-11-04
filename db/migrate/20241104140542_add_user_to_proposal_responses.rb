class AddUserToProposalResponses < ActiveRecord::Migration[7.0]
  disable_ddl_transaction!

  def change
    ActiveRecord::Base.connection.execute("SET lock_timeout TO '10s'")
    add_reference :proposal_responses, :user, null: false, index: { algorithm: :concurrently }
    add_index :proposal_responses, [:user_id, :created_at], 
      name: 'idx_proposal_responses_by_user_and_date',
      algorithm: :concurrently
  end
end