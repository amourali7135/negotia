class ProposalResponse < ApplicationRecord
  belongs_to :proposal
  belongs_to :user

  validates :status, presence: true
  validates :user_id, uniqueness: { scope: :proposal_id, message: "has already responded to this proposal" }
  validates :comment, presence: true, length: { minimum: 1 }
  validate :user_is_part_of_negotiation
  validate :user_is_not_proposal_creator

  enum status: { accepted: 0, rejected: 1, countered: 2 }, _prefix: true

  after_save :update_proposal_status

  private

  def update_proposal_status
    return unless proposal.all_parties_responded?

    new_status = if proposal.accepted?
                   :accepted
                 elsif proposal_responses.all?(&:rejected?)
                   :rejected
                 else
                   :countered
                 end
    proposal.update(status: new_status)
  end

  def user_is_part_of_negotiation
    return if proposal.negotiation.users.include?(user)

    errors.add(:user, "must be part of the negotiation")
  end

  def user_is_not_proposal_creator
    return unless user_id == proposal.proposed_by_id

    errors.add(:user, "cannot respond to their own proposal")
  end
end
