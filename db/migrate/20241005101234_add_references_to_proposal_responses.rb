# class AddReferencesToProposalResponses < ActiveRecord::Migration[7.0]
#   def change
#     change_table :proposalresponses do |t|
#       t.references :proposal, null: false, foreign_key: true
#       t.references :user, null: false, foreign_key: true
#     end

#     add_index :proposalresponses, [:proposal_id, :user_id], unique: true
#   end
# end

class AddReferencesToProposalResponses < ActiveRecord::Migration[7.0]
  disable_ddl_transaction!

  def change
    # Add references with indexes
    add_reference :proposal_responses, :proposal, null: false, index: { algorithm: :concurrently }
    add_reference :proposal_responses, :user, null: false, index: { algorithm: :concurrently }

    # Add unique index for combined columns
    add_index :proposalresponses, [:proposal_id, :user_id], unique: true, algorithm: :concurrently
  end
end