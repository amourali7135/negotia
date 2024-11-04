class ValidateIssueForeignKeyInIssueAnalyses < ActiveRecord::Migration[7.0]
  def change
    validate_foreign_key :issue_analyses, :issues
  end
end