class CreatePracticesessioutcomes < ActiveRecord::Migration[7.0]
  def change
    create_table :practicesessioutcomes do |t|
      t.text :overall_result
      t.integer :satisfaction_level
      t.text :lessons_learned
      t.text :next_steps
      t.references :practice_session, null: false, foreign_key: true
      t.timestamps
    end
  end
end
