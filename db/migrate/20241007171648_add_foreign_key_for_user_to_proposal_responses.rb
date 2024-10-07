class AddForeignKeyForUserToProposalResponses < ActiveRecord::Migration[7.0]
  def change
    add_foreign_key :proposalresponses, :users, validate: false
  end
end
