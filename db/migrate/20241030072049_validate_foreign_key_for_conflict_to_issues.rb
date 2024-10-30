class ValidateForeignKeyForConflictToIssues < ActiveRecord::Migration[7.0]
  def change
    validate_foreign_key :issues, :conflicts, column: :conflict_id
  end
end
