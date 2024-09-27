class ProposalresponsesController < ApplicationController
  before_action :set_proposal

  def new
  end

  def create
    @proposal_response = @proposal.proposal_responses.build(proposal_response_params)
    @proposal_response.user = current_user

    if @proposal_response.save
      redirect_to negotiation_path(@proposal.negotiation), notice: 'Response submitted successfully.'
    else
      redirect_to negotiation_path(@proposal.negotiation), alert: 'Failed to submit response.'
    end
  end

  private

  def set_proposal
    @proposal = Proposal.find(params[:proposal_id])
  end

  def proposal_response_params
    params.require(:proposal_response).permit(:status, :comment)
  end
end
