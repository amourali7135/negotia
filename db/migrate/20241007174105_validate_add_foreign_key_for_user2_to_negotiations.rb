class ValidateAddForeignKeyForUser2ToNegotiations < ActiveRecord::Migration[7.0]
  def change
    validate_foreign_key :negotiations, :users
  end
end
