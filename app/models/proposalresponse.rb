class Proposalresponse < ApplicationRecord
  belongs_to :proposal
  belongs_to :user

  validates :status, presence: true
  validates :user_id, uniqueness: { scope: :proposal_id, message: "has already responded to this proposal" }

  enum status: { accepted: 0, rejected: 1, countered: 2 }
end
