class CreateProposalResponses < ActiveRecord::Migration[7.0]
  def change
    create_table :proposal_responses do |t|
      # t.references :proposal, null: false, foreign_key: true, index: true
      # t.references :user, null: false, foreign_key: true
      t.integer :status, null: false
      t.text :comment, null: false
      t.timestamps

      # t.index [:proposal_id, :user_id], unique: true, name: 'idx_proposal_responses_on_proposal_and_user'
      # t.index [:user_id, :created_at], name: 'idx_proposal_responses_by_user_and_date'
      # t.index [:status, :created_at], name: 'idx_proposal_responses_by_status_and_date'
    end
    # add_index :proposal_responses, [:proposal_id, :user_id], unique: true
    add_index :proposal_responses, [:status, :created_at], 
      name: 'idx_proposal_responses_by_status_and_date'
  end
end