class AddReferencesToProposalResponses < ActiveRecord::Migration[7.0]
  def change
    change_table :proposalresponses do |t|
      t.references :proposal, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
    end

    add_index :proposalresponses, [:proposal_id, :user_id], unique: true
  end
end
