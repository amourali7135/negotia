class Proposal < ApplicationRecord
  belongs_to :negotiation
  belongs_to :proposed_by, class_name: 'User'
  belongs_to :issue, optional: true
  has_many :proposal_responses, dependent: :destroy

  validates :content, presence: true

  scope :for_issue, ->(issue_id) { where(issue_id:) }

  def response_for(user)
    proposal_responses.find_by(user:)
  end

  def accepted?
    proposal_responses.all? { |response| response.accepted? }
  end
end
