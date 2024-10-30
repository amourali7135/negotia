class AddForeignKeyForProposalToProposalResponses < ActiveRecord::Migration[7.0]
  def change
    add_foreign_key :proposal_responses, :proposals, column: :proposal_id, validate: false
  end
end
