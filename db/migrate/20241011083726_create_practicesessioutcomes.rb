class CreatePracticeSessionOutcomes < ActiveRecord::Migration[7.0]
  def change
    create_table :practice_session_outcomes do |t|
      t.integer :overall_result, null: false
      t.integer :satisfaction_level, null: false
      t.text :lessons_learned, null: false
      t.text :next_steps, null: false
      t.text :notes
      
      t.references :practice_session, null: false, foreign_key: true
      t.timestamps
    end
  end
end
