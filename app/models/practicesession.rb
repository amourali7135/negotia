class PracticeSession < ApplicationRecord
  belongs_to :conflict
  belongs_to :user
  has_many :issue_analyses, dependent: :destroy
  has_one :practice_session_outcome, dependent: :destroy
  accepts_nested_attributes_for :issue_analyses # My experiment, let's see if it works

  enum status: { pending: 0, in_progress: 1, completed: 2 }, _prefix: true

  validates :conflict, :user, presence: true
  validates :status, inclusion: { in: statuses.keys }
  validate :user_belongs_to_conflict

  scope :in_progress, -> { where(status: statuses[:in_progress]) }
  scope :completed, -> { where(status: statuses[:completed]) }
  scope :pending, -> { where(status: statuses[:pending]) }

  def start!
    update!(status: :in_progress) if status_pending?
  end

  def complete!
    return false unless can_complete?

    transaction do
      update!(status: :completed)
      create_practice_session_outcome! unless practice_session_outcome
    end
  rescue ActiveRecord::RecordInvalid => e
    errors.add(:base, "Failed to complete practice session: #{e.message}")
    false
  end

  def can_complete?
    status_in_progress? && issue_analyses.any?
  end

  private

  def user_belongs_to_conflict
    return if conflict&.users&.include?(user)

    errors.add(:user, "must be involved in the conflict")
  end
end
