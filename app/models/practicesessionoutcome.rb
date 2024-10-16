class PracticeSessionOutcome < ApplicationRecord
  belongs_to :practice_session

  validates :practice_session, presence: true
  validates :overall_result, presence: true
  validates :satisfaction_level, presence: true, inclusion: { in: 1..10 }
  validates :lessons_learned, :next_steps, presence: true, length: { minimum: 3 }

  after_create :complete_practice_session

  private

  def complete_practice_session
    practice_session.update!(status: :completed) unless practice_session.completed?
  end
end
