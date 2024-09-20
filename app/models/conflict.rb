class Conflict < ApplicationRecord
  belongs_to :user
  has_many :issues, dependent: :destroy

  enum priority: { lowest: 0, low: 1, average: 2, high: 3, very_high: 4 }
  enum status: { pending: 0, in_progress: 1, completed: 2, stalemate: 3 }

  validates :title, presence: true
  validates :problem, presence: true, length: { minimum: 3 }
  validates :status, presence: true
  validates :opponent, presence: true
  validates :priority, presence: true
  validates :objective, presence: true

  scope :by_priority, -> { order(priority: :asc) }
  scope :by_status, ->(status) { where(status:) }
  scope :in_progress, -> { where(status: 'in_progress') }
  scope :completed, -> { where(status: 'completed') }
  scope :pending, -> { where(status: 'pending') }
  scope :stalemate, -> { where(status: 'stalemate') }
end
