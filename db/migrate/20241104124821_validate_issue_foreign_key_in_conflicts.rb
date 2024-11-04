class ValidateIssueForeignKeyInConflicts < ActiveRecord::Migration[7.0]
  def change
    validate_foreign_key :conflicts, :issues
  end
end
