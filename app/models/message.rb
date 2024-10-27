class Message < ApplicationRecord
  belongs_to :negotiation
  belongs_to :user

  validates :content, presence: true, length: { maximum: 2000 }
  validate :user_is_negotiation_participant

  scope :ordered, -> { order(created_at: :asc) }
  scope :recent, -> { order(created_at: :desc) }
  scope :unread_by, lambda { |user|
    where.not(user:)
         .where('created_at > ?', user.last_read_at || Time.current)
  }

  # Callbacks
  after_create_commit :broadcast_message

  private

  # Will this work with two users?  Check.
  def user_is_negotiation_participant
    return if negotiation.participants.include?(user)

    errors.add(:user, "must be a participant in this negotiation")
  end

  def broadcast_message
    broadcast_append_to(
      "negotiation_#{negotiation.id}_messages",
      target: "messages",
      partial: "messages/message",
      locals: { message: self }
    )
  end
end
