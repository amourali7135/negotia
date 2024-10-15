class PracticeSession < ApplicationRecord
  belongs_to :conflict
  belongs_to :user
  has_many :issueanalyses, dependent: :destroy
  has_one :practice_session_outcome, dependent: :destroy

  enum status: { in_progress: 0, completed: 1, pending: 2 }

  validates :conflict, presence: true
  validates :user, presence: true
end
