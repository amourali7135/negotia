class ProposalsController < ApplicationController
  before_action :set_negotiation
  # before_action :ensure_negotiation_participant

  def new
    @proposal = @negotiation.proposals.build
    @issues = @negotiation.issues
  end

  def create
    @proposal = @negotiation.proposals.build(proposal_params)
    # Which one of these two?  Figure it out asap.
    @proposal.proposed_by = current_user
    # @proposal.user = current_user

    if @proposal.save
      redirect_to @negotiation, notice: 'Proposal was successfully created.'
    else
      @issues = @negotiation.issues
      render :new, status: :unprocessable_entity
    end
  end

  private

  def set_negotiation
    @negotiation = Negotiation.find(params[:negotiation_id])
  end

  def proposal_params
    params.require(:proposal).permit(:content, :issue_id, :negotiation_id)
  end
end
