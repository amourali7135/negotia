class ValidateNegotiationForeignKeyInProposals < ActiveRecord::Migration[7.0]
  def change
    validate_foreign_key :proposals, :negotiations
  end
end