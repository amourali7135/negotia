class ValidatePracticeSessionForeignKeyInIssueAnalyses < ActiveRecord::Migration[7.0]
  def change
    validate_foreign_key :issue_analyses, :practice_sessions
  end
end