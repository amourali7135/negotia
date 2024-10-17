class CreateConflicts < ActiveRecord::Migration[7.0]
  def change
    create_table :conflicts do |t|
      t.string :title, null: false
      t.text :problem, null: false
      t.integer :status, default: 0, null: false
      t.string :opponent, null: false
      t.integer :priority, default: 0, null: false
      t.integer :conflict_type, default: 0, null: false
      t.text :objective, null: false
      t.references :user, null: false, foreign_key: true, index: true

      t.timestamps
    end

    add_index :conflicts, :status
    add_index :conflicts, :priority
    add_index :conflicts, :conflict_type
  end
end