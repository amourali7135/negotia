class NegotiationsController < ApplicationController
  before_action :set_negotiation, only: %i[show respond accept decline]

  def index
    # @negotiations = current_user.all_negotiations
    @negotiations = Negotiation.where(user_id: current_user.id)
  end

  def show
    @negotiation = Negotiation.includes(:issues, proposals: %i[proposed_by issue]).find(params[:id])
    @messages = @negotiation.messages.order(created_at: :asc)
    @message = Message.new
    @proposals = @negotiation.proposals.order(created_at: :desc)
    # @negotiation_issues = @negotiation.issues
  end

  def new
    @negotiation = Negotiation.new
    @user_conflicts = current_user.conflicts
    @conflict = Conflict.find(params[:conflict_id])
    # @other_users = User.where.not(id: current_user.id)
  end

  def create
    @negotiation = Negotiation.new(negotiation_params)
    @negotiation.user1 = current_user
    # @negotiation.initiator = current_user
    @negotiation.status = :pending

    if @negotiation.save
      # Send invitation email here
      # NegotiationMailer.invitation(@negotiation).deliver_later
      redirect_to @negotiation, notice: 'Negotiation was successfully initiated.'
    else
      @user_conflicts = current_user.conflicts
      @conflict = Conflict.find(params[:conflict_id])
      # @other_users = User.where.not(id: current_user.id)
      render :new, status: :unprocessable_entity
    end
  end

  def respond
    @user_conflicts = current_user.conflicts
  end

  def accept
    if @negotiation.update(accept_params.merge(status: :active))
      redirect_to @negotiation, notice: 'Negotiation accepted successfully.'
    else
      render :respond
    end
  end

  def decline
    @negotiation.update(status: :cancelled)
    redirect_to negotiations_path, notice: 'Negotiation declined.'
  end

  def update
    if (@negotiation.pending? && @negotiation.user1 == current_user) || @negotiation.user2 == current_user
      @negotiation.update(status: :active)
      redirect_to @negotiation, notice: 'Negotiation accepted.'
    else
      redirect_to @negotiation, alert: 'Unable to update negotiation.'
    end
  end

  def cancel
    if @negotiation.user1 == current_user || @negotiation.user2 == current_user
      @negotiation.update(status: :cancelled)
      redirect_to negotiations_path, notice: 'Negotiation cancelled.'
    else
      redirect_to @negotiation, alert: 'You are not authorized to cancel this negotiation.'
    end
  end

  def resolve
    @negotiation = Negotiation.find(params[:id])
    if @negotiation.resolve(params[:resolution_notes])
      redirect_to @negotiation, notice: 'Negotiation successfully resolved.'
    else
      render :show
    end
  end

  private

  def set_negotiation
    @negotiation = Negotiation.find(params[:id])
  end

  def negotiation_params
    params.require(:negotiation).permit(:user2_id, :conflict1_id, :conflict2_id, :user1_id)
  end

  def accept_params
    params.require(:negotiation).permit(:conflict2_id)
  end
end
