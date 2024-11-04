class AddForeignKeyForNegotiationInProposals < ActiveRecord::Migration[7.0]
  def change
    add_foreign_key :proposals, :negotiations, validate: false
  end
end