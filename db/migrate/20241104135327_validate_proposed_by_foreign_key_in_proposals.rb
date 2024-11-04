class ValidateProposedByForeignKeyInProposals < ActiveRecord::Migration[7.0]
  def change
    validate_foreign_key :proposals, :users, column: :proposed_by_id
  end
end