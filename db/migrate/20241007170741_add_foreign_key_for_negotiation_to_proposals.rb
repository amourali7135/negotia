class AddForeignKeyForNegotiationToProposals < ActiveRecord::Migration[7.0]
  def change
    add_foreign_key :proposals, :negotiations, column: :negotiation_id, validate: false
  end
end
