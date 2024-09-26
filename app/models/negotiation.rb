class Negotiation < ApplicationRecord
  # For now I'll force users to register and fill in their conflict information.  For later, I'll make it optional with a big warning before they enter.
  belongs_to :user1, class_name: 'User'
  belongs_to :user2, class_name: 'User'
  belongs_to :conflict1, class_name: 'Conflict'
  belongs_to :conflict2, class_name: 'Conflict', optional: true
  belongs_to :initiator, class_name: 'User'

  has_many :messages, dependent: :destroy
  # has_many :proposals, dependent: :destroy
  # has_many :negotiation_issues, dependent: :destroy
  # has_many :issues, through: :negotiation_issues

  enum status: { pending: 0, in_progress: 1, resolved: 2, stalemate: 3, cancelled: 4 }

  validates :user1, :user2, :conflict1, :initiator, presence: true
  validate :users_are_different
  validate :conflicts_belong_to_respective_users

  scope :upcoming_deadline, ->(days) { where(deadline: Time.current..(Time.current + days.days)) }

  def initiated_by?(user)
    initiator == user
  end

  def add_participant(user)
    negotiation_participants.create(user:)
  end

  private

  def users_are_different
    errors.add(:base, "Both users must be different users") if user1.user_id == user2.user_id
  end

  # First generation
  # def conflicts_belong_to_respective_users
  #   errors.add(:initiator_conflict, "must belong to the initiator") unless initiator_conflict.user_id == initiator_id
  #   return if respondent_conflict.user_id == respondent_id

  #   errors.add(:respondent_conflict,
  #              "must belong to the respondent")
  # end

  def conflicts_belong_to_respective_users
    errors.add(:conflict1, "must belong to User1") unless conflict1.user_id == user1_id
    errors.add(:conflict2, "must belong to User2") if conflict2 && conflict2.user_id != user2_id
  end
end
