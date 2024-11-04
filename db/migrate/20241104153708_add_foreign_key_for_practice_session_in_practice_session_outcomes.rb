class AddForeignKeyForPracticeSessionInPracticeSessionOutcomes < ActiveRecord::Migration[7.0]
  def change
    add_foreign_key :practice_session_outcomes, :practice_sessions, validate: false
  end
end