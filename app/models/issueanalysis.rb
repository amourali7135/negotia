class IssueAnalysis < ApplicationRecord
  belongs_to :practice_session
  belongs_to :issue

  enum status: { pending: 0, addressed: 1, skipped: 2 }
  enum importance: { low: 0, medium: 1, high: 2, critical: 3 }
  enum difficulty: { easy: 0, moderate: 1, challenging: 2, very_difficult: 3 }

  validates :practice_session, :issue, presence: true
  validates :satisfaction_level, inclusion: { in: 1..10 }, allow_nil: true
  validates :status, :importance, :difficulty, presence: true
  validates :issue, presence: true

  scope :addressed, -> { where(status: :addressed) }
  scope :pending, -> { where(status: :pending) }
  scope :skipped, -> { where(status: :skipped) }

  # Added an address! method to mark an issue as addressed and set the satisfaction level.
  def address!(satisfaction_level)
    update!(status: :addressed, satisfaction_level:)
  end
end
