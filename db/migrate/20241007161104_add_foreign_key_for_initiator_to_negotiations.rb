class AddForeignKeyForInitiatorToNegotiations < ActiveRecord::Migration[7.0]
  def change
    add_foreign_key :negotiations, :users, column: :initiator_id
  end
end
