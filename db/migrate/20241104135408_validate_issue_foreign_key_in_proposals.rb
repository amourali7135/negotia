class ValidateIssueForeignKeyInProposals < ActiveRecord::Migration[7.0]
  def change
    validate_foreign_key :proposals, :issues
  end
end