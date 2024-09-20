class CreateConflicts < ActiveRecord::Migration[7.0]
  def change
    create_table :conflicts do |t|
      t.string :title
      t.text :problem
      t.integer :status, default: 'pending'
      t.string :opponent
      t.integer :priority, default: 'pending'
      t.text :objective
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
