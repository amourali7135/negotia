class CreatePracticesessions < ActiveRecord::Migration[7.0]
  def change
    create_table :practicesessions do |t|
      t.text :outcome_summary
      t.integer :satisfaction_level, default: 0
      t.text :notes
      t.integer :status, default: 'pending'
      
      t.references :user, null: false, foreign_key: true
      t.references :conflict, null: false, foreign_key: true
      t.timestamps
    end
  end
end
