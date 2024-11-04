class AddForeignKeyForUserInProposalResponses < ActiveRecord::Migration[7.0]
  def change
    add_foreign_key :proposal_responses, :users, validate: false
  end
end