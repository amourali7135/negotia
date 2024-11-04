class AddForeignKeyForConflictInPracticeSessions < ActiveRecord::Migration[7.0]
  def change
    # add_foreign_key :practice_sessions, :conflicts, validate: false
    add_foreign_key :practice_sessions, :conflicts, column: :conflict_id, validate: false
  end
end

