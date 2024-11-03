class CreatePracticeSessions < ActiveRecord::Migration[7.0]
  def change
    create_table :practice_sessions do |t|
      # t.text :outcome_summary
      # t.integer :satisfaction_level, default: 0
      # t.text :notes
      t.integer :status, null: false, default: 0
      
      # t.references :user, null: false, foreign_key: true
      # t.references :conflict, null: false, foreign_key: true
      t.timestamps
    end
    # add_index :practice_sessions, [:user_id, :conflict_id]
  end
end
