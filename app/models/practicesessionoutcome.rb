class PracticeSessionOutcome < ApplicationRecord
  belongs_to :practice_session

  validates :practice_session, presence: true
  validates :overall_result, presence: true
  validates :satisfaction_level, presence: true, inclusion: { in: 1..10 }
  validates :lessons_learned, presence: true, length: { minimum: 3 }
  validates :next_steps, presence: true, length: { minimum: 3 }
end
