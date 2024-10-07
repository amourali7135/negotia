class AddForeignKeyForInitiatorToNegotiations < ActiveRecord::Migration[7.0]
  def change
    add_foreign_key :negotiations, :users, column: :initiator_id, validate: false
  end
end
