class ConflictsController < ApplicationController
  before_action :set_conflict, only: %i[show edit update destroy]

  def index
    @conflicts = current_user.conflicts
  end

  def show
    @issues = @conflict.issues.includes(:user)
  end

  def new
    @conflict = current_user.conflicts.new
  end

  def create
    @conflict = current_user.conflicts.new(conflict_params)
    if @conflict.save
      redirect_to @conflict, notice: 'Conflict was successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @conflict.update(conflict_params)
      redirect_to @conflict, notice: 'Conflict was successfully updated.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @conflict.destroy
    redirect_to conflicts_url, notice: 'Conflict was successfully destroyed.'
  end

  private

  def set_conflict
    @conflict = current_user.conflicts.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    redirect_to conflicts_url, alert: 'Conflict not found.'
  end

  def conflict_params
    params.require(:conflict).permit(:title, :problem, :status, :opponent, :priority, :objective, :conflict_type)
  end
end
