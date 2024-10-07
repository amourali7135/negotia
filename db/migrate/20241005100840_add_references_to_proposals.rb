class AddReferencesToProposals < ActiveRecord::Migration[7.0]
  def change
    change_table :proposals do |t|
      t.references :negotiation, null: false, foreign_key: true
      t.references :proposed_by, null: false, foreign_key: { to_table: :users }
      t.references :issue, foreign_key: true
    end
  end
end