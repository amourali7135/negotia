class CreateIssueanalyses < ActiveRecord::Migration[7.0]
  def change
    create_table :issueanalyses do |t|    
      t.text :alternative_solutions
      t.text :possible_solutions
      
      t.text :best_alternative
      t.text :worst_alternative
      
      t.integer :difficulty, default: 0
      
      t.text :desired_outcome
      t.text :minimum_acceptable_outcome
      t.text :notes
      t.boolean :is_flexible, default: false
      t.integer :priority, default: 0
      t.integer :satisfaction_level, default: 0
      t.references :issue, null: false, foreign_key: true
      t.references :practice_session, null: false, foreign_key: true
      t.references :practice_session_outcome, null: false, foreign_key: true

      t.timestamps
    end
  end
end
