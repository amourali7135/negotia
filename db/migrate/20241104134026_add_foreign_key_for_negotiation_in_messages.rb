class AddForeignKeyForNegotiationInMessages < ActiveRecord::Migration[7.0]
  def change
    add_foreign_key :messages, :negotiations, on_delete: :cascade, validate: false
  end
end