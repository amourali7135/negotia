class Issue < ApplicationRecord
  belongs_to :conflict
  has_many :proposals, dependent: :destroy

  enum priority: { low: 0, average: 1, high: 2, critical: 3 }, _prefix: true
  enum status: { pending: 0, in_progress: 1, resolved: 2 }, _prefix: true

  validates :title, presence: true, uniqueness: { scope: :conflict_id }
  validates :status, presence: true
  validates :priority, presence: true
  validates :explanation, presence: true, length: { minimum: 3 }

  scope :by_priority, -> { order(priority: :asc) }
  scope :by_status, ->(status) { where(status:) }
  scope :in_progress, -> { where(status: 'in_progress') }
  scope :pending, -> { where(status: 'pending') }
end
