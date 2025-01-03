class Conflict < ApplicationRecord
  belongs_to :user
  has_many :issues, dependent: :destroy
  has_many :negotiations_as_conflict1, class_name: 'Negotiation', foreign_key: 'conflict1_id'
  has_many :negotiations_as_conflict2, class_name: 'Negotiation', foreign_key: 'conflict2_id'
  has_many :negotiations, dependent: :destroy
  has_many :practice_sessions, dependent: :destroy
  has_many :practice_session_outcomes, dependent: :destroy

  enum priority: { lowest: 0, low: 1, ordinary: 2, high: 3, very_high: 4 }, _prefix: true
  enum status: { pending: 0, in_progress: 1, completed: 2, stalemate: 3 }, _prefix: true
  enum conflict_type: { personal: 0, professional: 1, legal: 2, other: 3 }, _prefix: true

  validates :title, presence: true, length: { minimum: 3 }
  validates :problem, presence: true, length: { minimum: 3 }
  validates :status, presence: true
  validates :opponent, presence: true, length: { minimum: 3 }
  validates :priority, presence: true
  validates :objective, presence: true
  validates :conflict_type, presence: true

  scope :by_priority, -> { order(priority: :asc) }
  scope :by_status, ->(status) { where(status:) }
  scope :in_progress, -> { where(status: 'in_progress') }
  scope :completed, -> { where(status: 'completed') }
  scope :pending, -> { where(status: 'pending') }
  scope :stalemate, -> { where(status: 'stalemate') }
end
