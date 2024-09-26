class NegotiationsController < ApplicationController
  before_action :set_negotiation, only: %i[show respond accept decline]

  def index
    # @negotiations = current_user.all_negotiations
    @negotiations = Negotiation.where(user_id: current_user.id)
  end

  def show
    # @messages = @negotiation.messages.order(created_at: :asc)
    # @message = Message.new
    # @proposals = @negotiation.proposals.order(created_at: :desc)
    # @negotiation_issues = @negotiation.issues
  end

  def new
    @negotiation = Negotiation.new
    @user_conflicts = current_user.conflicts
    @other_users = User.where.not(id: current_user.id)
  end

  def create
    @negotiation = Negotiation.new(negotiation_params)
    @negotiation.user1 = current_user
    @negotiation.initiator = current_user
    @negotiation.status = :pending

    if @negotiation.save
      # Send invitation email here
      redirect_to @negotiation, notice: 'Negotiation was successfully initiated.'
    else
      @user_conflicts = current_user.conflicts
      @other_users = User.where.not(id: current_user.id)
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
