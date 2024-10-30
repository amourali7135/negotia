class CreateIssues < ActiveRecord::Migration[7.0]
  def change
    create_table :issues do |t|
      t.string :title, null: false
      t.integer :priority, default: 0, null: false
      t.text :explanation, null: false
      t.integer :status, default: 0, null: false
      # t.references :conflict, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true, index: true
      # t.references :conflict, null: false, index: { algorithm: :concurrently }
      t.timestamps
    end

    add_index :issues, :priority
    add_index :issues, :status
    # add_index :issues, [:conflict_id, :priority]
    # add_index :issues, :priority, algorithm: :concurrently
    # add_index :issues, :status, algorithm: :concurrently
    # add_index :issues, [:conflict_id, :priority], algorithm: :concurrently
  end
end
