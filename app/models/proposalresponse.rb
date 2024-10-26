class ProposalResponse < ApplicationRecord
  belongs_to :proposal
  belongs_to :user
  delegate :proposed_by, to: :proposal
  delegate :negotiation, to: :proposal  # This provides a clean way to access the negotiation through the proposal while being more efficient than creating an Active Record association. You can still use it the same way:

  validates :status, presence: true
  validates :user_id, uniqueness: { scope: :proposal_id, message: "has already responded to this proposal" }
  validates :comment, presence: true, length: { minimum: 1, maximum: 1000 }
  validate :user_is_part_of_negotiation
  validate :user_is_not_proposal_creator
  validate :proposal_is_still_pending, on: :create

  enum status: { accepted: 0, rejected: 1, countered: 2 }, _prefix: true

  after_save :update_proposal_status
  after_create :notify_proposal_creator
  after_create :send_email_notification

  scope :accepted, -> { where(status: :accepted) }
  scope :rejected, -> { where(status: :rejected) }
  scope :countered, -> { where(status: :countered) }

  def can_be_modified?
    proposal.status_pending?
  end

  private

  def notify_proposal_creator
    Notification.create(
      recipient: proposal.proposed_by,
      action: notification_action,
      notifiable: self,
      status: :unread
    )
  end

  def notification_action
    case status
    when 'accepted' then 'accepted your proposal'
    when 'rejected' then 'rejected your proposal'
    when 'countered' then 'countered your proposal'
    end
  end

  def send_email_notification
    ProposalMailer.response_notification(self).deliver_later
  end

  def update_proposal_status
    return unless proposal.all_parties_responded?

    new_status = determine_proposal_status
    proposal.update(status: new_status)
  end

  def determine_proposal_status
    if all_responses_accepted?
      :accepted
    elsif any_responses_rejected?
      :rejected
    else
      :countered
    end
  end

  def all_responses_accepted?
    proposal.proposal_responses.all?(&:accepted?)
  end

  def any_responses_rejected?
    proposal.proposal_responses.any?(&:rejected?)
  end

  def user_is_part_of_negotiation
    return if negotiation.users.include?(user)

    errors.add(:user, "must be part of the negotiation")
  end

  def user_is_not_proposal_creator
    return unless user_id == proposal.proposed_by_id

    errors.add(:user, "cannot respond to their own proposal")
  end

  def proposal_is_still_pending
    return if proposal.status_pending?

    errors.add(:base, "cannot respond to a proposal that is no longer pending")
  end
end
