class AddForeignKeyForConflictToIssues < ActiveRecord::Migration[7.0]
  def change
    add_foreign_key :issues, :conflicts, column: :conflict_id, validate: false
  end
end
