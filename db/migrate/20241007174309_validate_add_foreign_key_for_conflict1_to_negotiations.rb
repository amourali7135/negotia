class ValidateAddForeignKeyForConflict1ToNegotiations < ActiveRecord::Migration[7.0]
  def change
    validate_foreign_key :negotiations, :conflicts
  end
end
