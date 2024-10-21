class PracticeSessionOutcome < ApplicationRecord
  belongs_to :practice_session

  enum overall_result: {
    very_negative: -2,
    negative: -1,
    neutral: 0,
    positive: 1,
    very_positive: 2
  }
  enum status: { in_progress: 0, completed: 1 }, _prefix: true

  validates :practice_session, presence: true
  validates :overall_result, presence: true
  validates :satisfaction_level, presence: true,
                                 numericality: { only_integer: true, greater_than_or_equal_to: 1, less_than_or_equal_to: 10 }
  validates :lessons_learned, :next_steps, presence: true, length: { minimum: 3, maximum: 1000 }

  after_create :complete_practice_session

  def successful?
    overall_result_positive? || overall_result_very_positive?
  end

  def high_satisfaction?
    satisfaction_level >= 8
  end

  def needs_improvement?
    overall_result_negative? || overall_result_very_negative? || satisfaction_level < 5
  end

  private

  def complete_practice_session
    practice_session.completed! unless practice_session.completed?
  end
end
