class ProposalMailer < ApplicationMailer
  def response_notification(proposal_response)
    @proposal_response = proposal_response
    @recipient = proposal_response.proposal.proposed_by
    @responder = proposal_response.user
    @proposal = proposal_response.proposal

    mail(
      to: @recipient.email,
      subject: "New response to your proposal in negotiation ##{@proposal.negotiation.id}"
    )
  end
end
