class AddForeignKeyForIssueInIssueAnalyses < ActiveRecord::Migration[7.0]
  def change
    add_foreign_key :issue_analyses, :issues, validate: false
  end
end