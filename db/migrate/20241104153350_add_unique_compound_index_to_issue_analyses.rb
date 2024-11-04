class AddUniqueCompoundIndexToIssueAnalyses < ActiveRecord::Migration[7.0]
  disable_ddl_transaction!

  def change
    ActiveRecord::Base.connection.execute("SET lock_timeout TO '10s'")
    add_index :issue_analyses, [:practice_session_id, :issue_id], 
      unique: true,
      algorithm: :concurrently
  end
end