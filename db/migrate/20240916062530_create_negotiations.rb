class CreateNegotiations < ActiveRecord::Migration[7.0]
  # For now I'll force users to register and fill in their conflict information.  For later, I'll make it optional with a big warning before they enter.
  def change
    create_table :negotiations do |t|
      # t.references :user1, null: false, foreign_key: { to_table: :users }
      # t.references :user2, null: false, foreign_key: { to_table: :users }
      # t.references :conflict1, null: false, foreign_key: { to_table: :conflicts }
      # t.references :conflict2, foreign_key: { to_table: :conflicts }
      # t.references :initiator, null: false, foreign_key: { to_table: :users }
      t.integer :status, default: 0, null: false, default: 'pending'
      t.timestamps
    end
  end
end
