class CreatePracticesessions < ActiveRecord::Migration[7.0]
  def change
    create_table :practicesessions do |t|
      t.references :user, null: false, foreign_key: true
      t.references :conflict, null: false, foreign_key: true
      t.text :outcome_summary
      t.integer :satisfaction_level, default: 0
#
      t.text :session_notes
      t.integer :status, default: 'pending'

      t.references :user, null: false, foreign_key: true
      t.integer :status, default: 0
      t.text :notes
      t.datetime :started_at
      t.datetime :completed_at

      t.timestamps
    end
  end
end
