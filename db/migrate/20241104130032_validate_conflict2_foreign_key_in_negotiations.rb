class ValidateConflict2ForeignKeyInNegotiations < ActiveRecord::Migration[7.0]
  def change
    validate_foreign_key :negotiations, :conflicts, column: :conflict2_id
  end
end