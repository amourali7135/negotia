class Proposal < ApplicationRecord
  belongs_to :negotiation
  belongs_to :proposed_by, class_name: 'User'
  belongs_to :issue, optional: true
  has_many :proposal_responses, dependent: :destroy

  enum status: { pending: 0, accepted: 1, rejected: 2, countered: 3 }

  validates :content, presence: true
  validates :proposed_by_id, :negotiation_id, presence: true
  validate :issue_belongs_to_negotiation, if: -> { issue.present? }

  scope :for_issue, ->(issue_id) { where(issue_id:) }

  # Callback for status change here

  def response_for(user)
    proposal_responses.find_by(user:)
  end

  def accepted?
    proposal_responses.all? { |response| response.accepted? }
  end

  private

  def issue_belongs_to_negotiation
    errors.add(:issue, "must belong to the same negotiation") unless negotiation.issues.include?(issue)
  end

  def all_parties_responded?
    proposal_responses.count == negotiation.users.count - 1  # Excluding the proposer
  end

end
