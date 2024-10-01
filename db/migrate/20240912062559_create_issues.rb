class CreateIssues < ActiveRecord::Migration[7.0]
  def change
    create_table :issues do |t|
      t.string :title, null: false
      t.integer :priority, default: 'average'
      t.boolean :compromise, null: false
      t.text :explanation, null: false
      t.text :ideal_outcome, null: false
      t.text :acceptable_outcome, null: false
      t.integer :status, default: 'pending'
      t.references :conflict, null: false, foreign_key: true

      t.timestamps
    end
  end
end
