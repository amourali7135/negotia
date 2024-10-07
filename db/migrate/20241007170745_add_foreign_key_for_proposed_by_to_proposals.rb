class AddForeignKeyForProposedByToProposals < ActiveRecord::Migration[7.0]
  def change
    add_foreign_key :proposals, :users, column: :proposed_by_id, validate: false
  end
end
