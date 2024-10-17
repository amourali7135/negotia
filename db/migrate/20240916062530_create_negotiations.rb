class CreateNegotiations < ActiveRecord::Migration[7.0]
  def change
    create_table :negotiations do |t|
      # t.references :user1, null: false, foreign_key: { to_table: :users }
      # t.references :user2, null: false, foreign_key: { to_table: :users }
      # t.references :conflict1, null: false, foreign_key: { to_table: :conflicts }
      # t.references :conflict2, foreign_key: { to_table: :conflicts }
      t.string :user2_email, null: false
      t.string :user2_name, null: false
      t.integer :status, default: 0, null: false
      t.datetime :resolved_at
      t.datetime :deadline
      
      t.timestamps
    end

    add_index :negotiations, :status
    add_index :negotiations, :deadline
    add_index :negotiations, :user2_email
    #If you plan to have a large number of negotiations, consider adding a unique constraint to prevent duplicate negotiations between the same users for the same conflicts:
    add_index :negotiations, [:user1_id, :user2_id, :conflict1_id, :conflict2_id], unique: true, name: 'index_negotiations_on_users_and_conflicts'
  end
end
