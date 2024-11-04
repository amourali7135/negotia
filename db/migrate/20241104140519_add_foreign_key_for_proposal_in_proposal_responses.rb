class AddForeignKeyForProposalInProposalResponses < ActiveRecord::Migration[7.0]
  def change
    add_foreign_key :proposal_responses, :proposals, validate: false
  end
end