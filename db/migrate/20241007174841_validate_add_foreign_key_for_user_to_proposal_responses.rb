class ValidateAddForeignKeyForUserToProposalResponses < ActiveRecord::Migration[7.0]
  def change
    validate_foreign_key :proposal_responses, :users
  end
end
