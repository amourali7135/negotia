class AddUniqueIndexToProposalResponses < ActiveRecord::Migration[7.0]
  disable_ddl_transaction!

  def change
    add_index :proposal_responses, [:proposal_id, :user_id], 
      unique: true, 
      name: 'idx_proposal_responses_on_proposal_and_user',
      algorithm: :concurrently
  end
end