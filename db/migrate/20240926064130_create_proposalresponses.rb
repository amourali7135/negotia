class CreateProposalresponses < ActiveRecord::Migration[7.0]
  def change
    create_table :proposalresponses do |t|
      t.references :proposal, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.string :status, null: false
      t.text :comment, null: false
      t.timestamps
    end
    add_index :proposal_responses, [:proposal_id, :user_id], unique: true

  end
end
