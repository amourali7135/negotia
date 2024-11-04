class ValidateUserForeignKeyInConflicts < ActiveRecord::Migration[7.0]
  def change
    validate_foreign_key :conflicts, :users
  end
end

