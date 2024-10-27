class CreateMessages < ActiveRecord::Migration[7.0]
  def change
    create_table :messages do |t|
      # t.references :negotiation, null: false, foreign_key: { on_delete: :cascade }
      # t.references :user, null: false, foreign_key: { on_delete: :cascade }
      t.text :content, null: false
      t.timestamps

      t.index [:negotiation_id, :created_at]
      t.index [:user_id, :created_at]
    end
  end
end
