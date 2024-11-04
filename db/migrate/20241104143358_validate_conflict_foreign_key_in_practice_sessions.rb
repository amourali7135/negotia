class ValidateConflictForeignKeyInPracticeSessions < ActiveRecord::Migration[7.0]
  def change
    validate_foreign_key :practice_sessions, :conflicts
  end
end