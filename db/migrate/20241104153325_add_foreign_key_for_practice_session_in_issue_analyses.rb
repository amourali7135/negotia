class AddForeignKeyForPracticeSessionInIssueAnalyses < ActiveRecord::Migration[7.0]
  def change
    add_foreign_key :issue_analyses, :practice_sessions, validate: false
  end
end