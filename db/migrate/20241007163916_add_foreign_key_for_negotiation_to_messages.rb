class AddForeignKeyForNegotiationToMessages < ActiveRecord::Migration[7.0]
  def change
    add_foreign_key :messages, :negotiations, column: :negotiation_id, validate: false
  end
end
