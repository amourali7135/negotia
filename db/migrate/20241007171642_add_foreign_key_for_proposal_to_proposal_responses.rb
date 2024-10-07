class AddForeignKeyForProposalToProposalResponses < ActiveRecord::Migration[7.0]
  def change
    add_foreign_key :proposalresponses, :proposals, validate: false
  end
end
