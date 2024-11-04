class ValidatePracticeSessionForeignKeyInPracticeSessionOutcomes < ActiveRecord::Migration[7.0]
  def change
    validate_foreign_key :practice_session_outcomes, :practice_sessions
  end
end