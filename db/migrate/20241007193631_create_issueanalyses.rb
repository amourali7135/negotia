class CreateIssueanalyses < ActiveRecord::Migration[7.0]
  def change
    create_table :issueanalyses do |t|
      t.references :issue, null: false, foreign_key: true
      t.references :practice_session, null: false, foreign_key: true
      t.text :user_notes
      t.text :desired_outcomes
      t.integer :satisfaction_level, default: 0

      t.references :issue, null: false, foreign_key: true
      t.text :desired_outcome
      t.text :minimum_acceptable_outcome
      t.text :alternative_solutions
      t.integer :priority, default: 0
      t.boolean :is_flexible, default: false

      t.references :practice_session_outcome, null: false, foreign_key: true
      t.references :issue, null: false, foreign_key: true
      t.text :desired_outcome
      t.text :minimum_acceptable_outcome
      t.text :alternative_solutions
      t.integer :priority, default: 0
      t.boolean :is_flexible, default: false

      t.references :practice_session, null: false, foreign_key: true
      t.references :issue, null: false, foreign_key: true
      t.text :practice_outcome # Store individual issue outcome for this session

      t.references :practice_session, null: false, foreign_key: true
      t.references :issue, null: false, foreign_key: true
      t.text :user_response
      t.text :feedback
      t.integer :status, default: 0


      t.references :issue, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.text :interests
      t.text :possible_solutions
      t.text :best_alternative
      t.text :worst_alternative
      t.text :ideal_outcome
      t.text :acceptable_outcome
      t.integer :importance, default: 0
      t.integer :difficulty, default: 0
      t.text :notes

      add_column :practice_issues, :interests, :text
      add_column :practice_issues, :possible_solutions, :text
      add_column :practice_issues, :best_alternative, :text
      add_column :practice_issues, :worst_alternative, :text
      add_column :practice_issues, :ideal_outcome, :text
      add_column :practice_issues, :acceptable_outcome, :text
      add_column :practice_issues, :importance, :integer, default: 0
      add_column :practice_issues, :difficulty, :integer, default: 0
      add_column :practice_issues, :notes, :text
      add_column :practice_issues, :actual_outcome, :text
      add_column :practice_issues, :outcome_satisfaction, :integer
      t.timestamps
    end
  end
end
