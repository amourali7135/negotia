class CreateNotifications < ActiveRecord::Migration[7.0]
  def change
    create_table :notifications do |t|
      t.string :action, null: false
      t.integer :status, default: 0, null: false
      # t.references :sender, null: false, foreign_key: { to_table: :users }
      # t.references :recipient, null: false, foreign_key: { to_table: :users }
      # t.references :notifiable, polymorphic: true, null: false
      t.timestamps
    end

    # add_index :notifications, [:recipient_id, :status]
    # add_index :notifications, [:sender_id, :created_at]
  end
end
