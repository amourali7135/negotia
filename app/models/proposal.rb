class Proposal < ApplicationRecord
  belongs_to :negotiation
  belongs_to :proposed_by, class_name: 'User'
  belongs_to :issue, optional: true
  has_many :proposal_responses, dependent: :destroy

  enum status: { pending: 0, accepted: 1, rejected: 2, countered: 3 }, _prefix: true

  validates :content, presence: true, length: { minimum: 2, maximum: 1000 }
  validates :proposed_by_id, :negotiation_id, presence: true
  validate :issue_belongs_to_negotiation, if: -> { issue.present? }
  validate :proposer_is_negotiation_participant

  scope :for_issue, ->(issue_id) { where(issue_id:) }
  scope :active, -> { where.not(status: :rejected) }

  # Callback for status change here
  after_save :update_status_based_on_responses, if: :saved_change_to_proposal_responses_count?
  after_save :update_status_based_on_responses, if: :saved_change_to_status?

  def response_for(user)
    proposal_responses.find_by(user:)
  end

  def accepted?
    proposal_responses.any? && proposal_responses.all?(&:accepted?)
  end

  def rejected?
    status_rejected?
  end

  def pending?
    status_pending?
  end

  def countered?
    status_countered?
  end

  private

  def issue_belongs_to_negotiation
    return if negotiation.issues.include?(issue)

    errors.add(:issue, "must belong to the same negotiation")
  end

  def proposer_is_negotiation_participant
    return if negotiation.users.include?(proposed_by)

    errors.add(:proposed_by, "must be a participant in the negotiation")
  end

  def all_parties_responded?
    proposal_responses.count == negotiation.users.count - 1  # Excluding the proposer
  end

  def update_status_based_on_responses
    return unless all_parties_responded?

    if proposal_responses.all?(&:accepted?)
      update(status: :accepted)
    elsif proposal_responses.any?(&:rejected?)
      update(status: :rejected)
    elsif proposal_responses.any?(&:countered?)
      update(status: :countered)
    end
  end
end
