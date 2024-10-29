class ProposalResponse < ApplicationRecord
  belongs_to :proposal
  belongs_to :user

  # This provides a clean way to access the negotiation through the proposal while being more efficient than creating an Active Record association. You can still use it the same way:
  delegate :proposed_by, :negotiation, to: :proposal

  enum status: { accepted: 0, rejected: 1, countered: 2 }, _prefix: true

  validates :status, presence: true
  validates :user_id, uniqueness: { scope: :proposal_id, message: "has already responded to this proposal" }
  validates :comment, presence: true, length: { minimum: 1, maximum: 1000 },
                      if: :comment_required?
  validate :user_is_part_of_negotiation
  validate :user_is_not_proposal_creator
  validate :proposal_is_still_pending, on: :create

  after_save :update_proposal_status, if: :saved_change_to_status?
  after_create :notify_and_broadcast_response

  scope :accepted, -> { where(status: :accepted) }
  scope :rejected, -> { where(status: :rejected) }
  scope :countered, -> { where(status: :countered) }
  scope :by_user, ->(user) { where(user:) }
  scope :for_proposal, ->(proposal) { where(proposal:) }

  def can_be_modified?
    proposal.status_pending? && !proposal.expired?
  end

  private

  def notify_and_broadcast_response
    notify_proposal_creator
    send_email_notification
    broadcast_notification
  end

  def notify_proposal_creator
    Notification.create!(
      recipient: proposed_by,
      sender: user,
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

  def broadcast_notification
    NotificationChannel.broadcast_to(
      proposed_by,
      {
        notification_html: notification_partial,
        message: "#{user.name} #{notification_action}",
        notification_id: id
      }
    )
  end

  def update_proposal_status
    return unless proposal.all_parties_responded?

    proposal.update!(status: determine_proposal_status)
  end

  def determine_proposal_status
    if proposal.proposal_responses.all?(&:status_accepted?)
      :accepted
    elsif proposal.proposal_responses.any?(&:status_rejected?)
      :rejected
    else
      :countered
    end
  end

  def notification_partial
    ApplicationController.renderer.render(
      partial: 'notifications/notification',
      locals: { notification: self }
    )
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
    return if proposal.status_pending? && !proposal.expired?

    errors.add(:base, "cannot respond to a proposal that is no longer pending or has expired")
  end

  def comment_required?
    status_rejected? || status_countered?
  end
end
