class ProposalResponsesController < ApplicationController
  before_action :set_proposal
  before_action :set_negotiation

  def new
    @proposal_response = @proposal.proposal_responses.build
  end

  def create
    @proposal_response = @proposal.proposal_responses.build(proposal_response_params)
    @proposal_response.user = current_user

    if @proposal_response.save
      redirect_to negotiation_path(@proposal.negotiation), notice: response_success_message(@proposal_response)
    else
      redirect_to negotiation_path(@proposal.negotiation), alert: @proposal_response.errors.full_messages.join(', ')
      render :new
    end
  end

  private

  def set_negotiation
    @negotiation = Negotiation.find(params[:negotiation_id])
  rescue ActiveRecord::RecordNotFound
    redirect_to root_path, alert: 'Negotiation not found.'
  end

  def set_proposal
    @proposal = Proposal.find(params[:proposal_id])
  rescue ActiveRecord::RecordNotFound
    redirect_to negotiation_path(params[:negotiation_id]), alert: 'Proposal not found.'
  end

  def proposal_response_params
    params.require(:proposal_response).permit(:status, :comment)
  end

  def response_success_message(response)
    case response.status
    when 'accepted'
      'You have accepted the proposal.'
    when 'rejected'
      'You have rejected the proposal.'
    when 'countered'
      'You have countered the proposal.'
    else
      'Response submitted successfully.'
    end
  end
end
