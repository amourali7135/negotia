class ConflictsController < ApplicationController
  before_action :set_conflict, only: %i[show edit update destroy]

  def index
    @conflicts = Conflict.where(user_id: current_user.id)
  end

  def show
    @conflict = Conflict.find(params[:id])
    @issues = @conflict.issues
  end

  def new
    @conflict = Conflict.new
  end

  def create
    @conflict = Conflict.new(conflict_params)
    if @conflict.save
      redirect_to @conflict, notice: 'Conflict was successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @conflict = Conflict.find(params[:id])
  end

  def update
    if @conflict.update(conflict_params)
      redirect_to @conflict, notice: 'Conflict was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @conflict.destroy
    redirect_to conflicts_url, notice: 'Conflict was successfully destroyed.'
  end

  private

  def set_conflict
    @conflict = Conflict.find(params[:id])
  end

  def conflict_params
    params.require(:conflict).permit(:title, :problem, :status, :opponent, :priority, :objective)
  end
end
