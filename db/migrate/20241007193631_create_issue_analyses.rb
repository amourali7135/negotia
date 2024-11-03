class CreateIssueAnalyses < ActiveRecord::Migration[7.0]
  def change
    create_table :issue_analyses do |t|    
      t.text :alternative_solutions
      t.text :possible_solutions
      t.text :best_alternative
      t.text :worst_alternative
      t.text :desired_outcome
      t.text :minimum_acceptable_outcome
      t.text :ideal_outcome
      t.text :expected_outcome
      t.text :notes
      
      t.integer :difficulty, null: false, default: 0
      t.integer :importance, null: false, default: 0
      t.integer :status, null: false, default: 0
      t.integer :satisfaction_level, default: 0
      
      t.boolean :is_flexible, null: false, default: false
      
      # t.references :issue, null: false, foreign_key: true
      # t.references :practice_session, null: false, foreign_key: true

      t.timestamps
    end
    # add_index :issue_analyses, [:practice_session_id, :issue_id], unique: true
  end
end
