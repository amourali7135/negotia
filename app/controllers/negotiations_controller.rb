class NegotiationsController < ApplicationController
  before_action :set_conflict
  before_action :set_negotiation, only: %i[show respond accept decline cancel resolve]
  rescue_from ActiveRecord::RecordNotFound, with: :negotiation_not_found

  def index
    @negotiations = current_user.negotiations
    # @negotiations = Negotiation.where(user1: current_user).or(Negotiation.where(user2: current_user))
  end

  def show
    # @negotiation = Negotiation.includes(:issues, proposals: %i[proposed_by issue]).find(params[:id]) GPT
    # @negotiation = @negotiation.includes(:issues, proposals: %i[proposed_by issue]) # Claude
    @negotiation = Negotiation.includes(conflict1: :issues, conflict2: :issues).find(params[:id])
    @messages = @negotiation.messages.order(created_at: :asc)
    @message = Message.new
    @proposals = @negotiation.proposals.order(created_at: :desc)
    @user1_issues = @negotiation.user1_issues
    @user2_issues = @negotiation.user2_issues
    @all_issues = @negotiation.all_issues
  end

  def new
    @negotiation = Negotiation.new
    @user_conflicts = current_user.conflicts
    # @conflict = Conflict.find_by(id: params[:conflict_id])
    @conflict = current_user.conflicts.find_by(id: params[:conflict_id])
    redirect_to conflicts_path, alert: 'Conflict not found' unless @conflict
  end

  def create
    @negotiation = Negotiation.new(negotiation_params)
    @negotiation.user1 = current_user
    @negotiation.status = :pending

    if @negotiation.save
      send_invitation(@negotiation)
      redirect_to @negotiation, notice: 'Negotiation was successfully initiated.  An invitation has been sent.'
    else
      @user_conflicts = current_user.conflicts
      @conflict = Conflict.find(params[:conflict_id])
      render :new, status: :unprocessable_entity
    end
  end

  def create
    @negotiation = Negotiation.new(negotiation_params.merge(user1: current_user))
    @negotiation.status = :pending

    if @negotiation.save
      send_invitation(@negotiation)
      redirect_to @negotiation, notice: 'Negotiation was successfully initiated. An invitation has been sent.'
    else
      @user_conflicts = current_user.conflicts
      @conflict = current_user.conflicts.find_by(id: params[:conflict_id])
      render :new, status: :unprocessable_entity
    end
  end

  def respond
    @user_conflicts = current_user.conflicts
  end

  def accept
    if @negotiation.update(accept_params.merge(status: :in_progress))
      redirect_to @negotiation, notice: 'Negotiation accepted successfully.'
    else
      render :respond
    end
  end

  def decline
    @negotiation.cancelled!
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

  # def cancel
  #   if @negotiation.user1 == current_user || @negotiation.user2 == current_user
  #     @negotiation.update(status: :cancelled)
  #     redirect_to negotiations_path, notice: 'Negotiation cancelled.'
  #   else
  #     redirect_to @negotiation, alert: 'You are not authorized to cancel this negotiation.'
  #   end
  # end  GPT

  def cancel
    @negotiation.cancelled!
    redirect_to negotiations_path, notice: 'Negotiation cancelled.'
  end # Claude

  # def resolve
  #   @negotiation = Negotiation.find(params[:id])
  #   if @negotiation.resolve(params[:resolution_notes])
  #     redirect_to @negotiation, notice: 'Negotiation successfully resolved.'
  #   else
  #     render :show
  #   end
  # end  GPT

  def resolve
    if @negotiation.resolve(params[:resolution_notes])
      redirect_to @negotiation, notice: 'Negotiation successfully resolved.'
    else
      flash.now[:alert] = 'Failed to resolve negotiation.'
      render :show
    end
  end # Claude

  def negotiation_not_found
    redirect_to negotiations_path, alert: 'Negotiation not found.'
  end

  private

  def set_conflict
    @conflict = Conflict.find(params[:conflict_id])
  end

  def set_negotiation
    @negotiation = Negotiation.find(params[:id])
  end

  def negotiation_params
    params.require(:negotiation).permit(:user2_id, :conflict1_id, :conflict2_id, :user1_id, :user2_name, :user2_email)
  end

  def accept_params
    params.require(:negotiation).permit(:conflict2_id)
  end

  def send_invitation(negotiation)
    # Assuming user2 is the user being invited
    NegotiationMailer.invitation(negotiation).deliver_later
  end
end
