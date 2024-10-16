class CreateProposals < ActiveRecord::Migration[7.0]
  def change
    create_table :proposals do |t|
      # t.references :negotiation, null: false, foreign_key: true
      # t.references :proposed_by, null: false, foreign_key: { to_table: :users }
      # t.references :issue, foreign_key: true
      t.text :content, null: false
      t.integer :status, default: 0, null: false, default: 'pending'
      t.timestamps
    end
  end
end
