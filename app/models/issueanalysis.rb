class IssueAnalysis < ApplicationRecord
  belongs_to :practice_session
  belongs_to :issue

  enum status: { pending: 0, addressed: 1, skipped: 2 }, _prefix: true
  enum importance: { low: 0, medium: 1, high: 2, critical: 3 }, _prefix: true
  enum difficulty: { easy: 0, moderate: 1, challenging: 2, very_difficult: 3 }, _prefix: true
  enum satisfaction_level: { moderate: 0, low: 1, high: 2, perfect: 3 }, _prefix: true

  validates :practice_session, :issue, presence: true
  validates :satisfaction_level, inclusion: { in: satisfaction_levels.keys }, allow_nil: true
  validates :status, :importance, :difficulty, presence: true
  validate :issue_belongs_to_practice_session_conflict

  scope :addressed, -> { where(status: statuses[:addressed]) }
  scope :pending, -> { where(status: statuses[:pending]) }
  scope :skipped, -> { where(status: statuses[:skipped]) }

  # Added an address! method to mark an issue as addressed and set the satisfaction level.
  def address!(satisfaction_level)
    raise ArgumentError, "Invalid satisfaction level" unless satisfaction_levels.values.include?(satisfaction_level)

    transaction do
      update!(status: :addressed, satisfaction_level:)
      practice_session.complete! if practice_session.issue_analyses.pending.empty?
    end
  end

  def skip!
    update!(status: :skipped)
  end

  private

  def issue_belongs_to_practice_session_conflict
    return if practice_session&.conflict&.issues&.exists?(id: issue_id)

    errors.add(:issue, "must belong to the practice session's conflict")
  end
end
