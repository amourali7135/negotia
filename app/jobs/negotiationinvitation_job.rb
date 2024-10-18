class NegotiationinvitationJob < ApplicationJob
  queue_as :default

  def perform(negotiation_id)
    negotiation = Negotiation.find(negotiation_id)
    NegotiationMailer.invitation(negotiation_id).deliver_now
  end
end
