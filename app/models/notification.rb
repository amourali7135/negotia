class Notification < ApplicationRecord
  belongs_to :recipient, class_name: 'User'
  belongs_to :sender, class_name: 'User'
  belongs_to :notifiable, polymorphic: true

  enum status: { unread: 0, read: 1 }

  scope :recent, -> { order(created_at: :desc).limit(10) }
  scope :unread, -> { where(status: :unread) }

  def message
    "#{sender.name} #{action}"
  end

  def notification_path
    case notifiable_type
    when 'ProposalResponse'
      Rails.application.routes.url_helpers.negotiation_proposal_path(
        notifiable.proposal.negotiation,
        notifiable.proposal
      )
      # Add more cases as needed
    end
  end

  scope :from_sender, ->(user_id) { where(sender_id: user_id) }
  scope :between_users, lambda { |user1_id, user2_id|
    where(sender_id: [user1_id, user2_id], recipient_id: [user1_id, user2_id])
  }
  scope :recent_senders, lambda { |recipient_id|
    where(recipient_id:)
      .select('DISTINCT ON (sender_id) *')
      .order('sender_id, created_at DESC')
  }
end
