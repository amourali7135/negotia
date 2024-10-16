class PracticeSession < ApplicationRecord
  belongs_to :conflict
  belongs_to :user
  has_many :issue_analyses, dependent: :destroy
  has_one :practice_session_outcome, dependent: :destroy

  enum status: { pending: 0, in_progress: 1, completed: 2 }

  validates :conflict, :user, presence: true
  validates :status, presence: true

  scope :in_progress, -> { where(status: :in_progress) }
  scope :completed, -> { where(status: :completed) }
  scope :pending, -> { where(status: :pending) }

  def complete!
    transaction do
      update!(status: :completed)
      create_practice_session_outcome! unless practice_session_outcome
    end
  end
end
