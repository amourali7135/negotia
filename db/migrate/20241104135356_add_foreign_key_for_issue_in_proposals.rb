class AddForeignKeyForIssueInProposals < ActiveRecord::Migration[7.0]
  def change
    add_foreign_key :proposals, :issues, validate: false
  end
end