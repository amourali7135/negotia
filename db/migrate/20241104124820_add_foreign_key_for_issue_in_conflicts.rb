class AddForeignKeyForIssueInConflicts < ActiveRecord::Migration[7.0]
  def change
    add_foreign_key :conflicts, :issues, column: :issue_id, validate: false
  end
end
