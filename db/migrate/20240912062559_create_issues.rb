class CreateIssues < ActiveRecord::Migration[7.0]
  def change
    create_table :issues do |t|
      t.string :title
      t.integer :priority, default: 'average'
      t.boolean :compromise
      t.text :explanation
      t.text :ideal_outcome
      t.text :acceptable_outcome
      t.integer :status, default: 'pending'
      t.text :offer
      t.references :conflict, null: false, foreign_key: true

      t.timestamps
    end
  end
end
