class Negotiation < ApplicationRecord
  # For now I'll force users to register and fill in their conflict information.  For later, I'll make it optional with a big warning before they enter.
  belongs_to :user1, class_name: 'User'
  belongs_to :user2, class_name: 'User' # , optional: true
  belongs_to :conflict1, class_name: 'Conflict'
  belongs_to :conflict2, class_name: 'Conflict', optional: true

  has_many :messages, dependent: :destroy
  has_many :proposals, dependent: :destroy
  has_many :proposal_responses, through: :proposals

  enum status: { pending: 0, in_progress: 1, resolved: 2, stalemate: 3, cancelled: 4 }

  validates :user1, :user2, :conflict1, :status, presence: true
  validate :users_are_different
  validate :conflicts_belong_to_respective_users
  validates :user2_email, presence: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :user2_name, presence: true
  validate :user2_email_matches_user2

  before_save :set_resolved_at, if: :resolved?
  #  Claude is terrifying, Jesus Christ. "The Negotiation model includes validations for user2_email and user2_name. It also has an after_create callback to set user2 if a matching user is found in the database."
  after_create :set_user2

  # You might want to add these methods to access issues indirectly
  # def issues
  #   Issue.where(conflict: [conflict, conflict2].compact)
  # end

  def user1_issues
    Issue.where(conflict: conflict1)
  end

  def user2_issues
    conflict2.present? ? Issue.where(conflict: conflict2) : Issue.none
  end

  def all_issues
    Issue.where(conflict: [conflict1, conflict2].compact).distinct
  end

  scope :upcoming_deadline, ->(days) { where(deadline: Time.current..(Time.current + days.days)) }

  def initiated_by?(user)
    initiator == user
  end

  def active?
    in_progress? || pending?
  end

  private

  def users_are_different
    errors.add(:base, "Both users must be different") if user1_id == user2_id
  end

  def conflicts_belong_to_respective_users
    errors.add(:conflict1, "must belong to User1") unless conflict1.user_id == user1_id
    errors.add(:conflict2, "must belong to User2") if conflict2 && conflict2.user_id != user2_id
  end

  def user2_email_matches_user2
    errors.add(:user2_email, "doesn't match User2's email") if user2 && user2.email != user2_email
  end

  # def conflict_comparison
  #   {
  #     user1: {
  #       user: user1.email,
  #       conflict_title: conflict1.title,
  #       conflict_description: conflict1.problem,
  #       issues: conflict1.issues.map { |issue| { title: issue.title, status: issue.status } }
  #     },
  #     user2: {
  #       user: user2.email,
  #       conflict_title: conflict2&.title,
  #       conflict_description: conflict2&.problem,
  #       issues: conflict2&.issues&.map { |issue| { title: issue.title, status: issue.status } } || []
  #     }
  #   }
  # end

  def resolve(resolution_notes)
    transaction do
      update!(status: :resolved, resolved_at: Time.current)
      conflict1.update!(status: 'resolved', resolution_notes:)
      conflict2&.update!(status: 'resolved', resolution_notes:)
    end
  end

  def set_resolved_at
    self.resolved_at = Time.current if status_changed? && resolved?
  end

  def other_user(user)
    user == user1 ? user2 : user1
  end

  def set_user2
    self.user2 = User.find_by(email: user2_email)
    save
  end

  # def issue_summary(conflict)
  #   return {} unless conflict

  #   issues = conflict.issues.map do |issue|
  #     status = negotiation_issue_statuses.find_by(issue:)&.status || 'not_in_negotiation'
  #     {
  #       title: issue.title,
  #       description: issue.description,
  #       severity: issue.severity,
  #       original_status: issue.status,
  #       negotiation_status: status
  #     }
  #   end

  #   {
  #     user: conflict.user.name,
  #     conflict_title: conflict.title,
  #     issues:
  #   }
  # end
end
