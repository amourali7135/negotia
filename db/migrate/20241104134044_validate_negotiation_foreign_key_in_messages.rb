class ValidateNegotiationForeignKeyInMessages < ActiveRecord::Migration[7.0]
  def change
    validate_foreign_key :messages, :negotiations
  end
end