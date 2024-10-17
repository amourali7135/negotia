class IssuesController < ApplicationController
  before_action :set_conflict
  before_action :set_issue, only: %i[show edit update destroy]

  def show
  end

  def new
    @issue = @conflict.issues.new
  end

  def create
    @issue = @conflict.issues.build(issue_params)
    @issue.user = current_user
    if @issue.save
      redirect_to conflict_issue_path(@conflict, @issue), notice: 'Issue was successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @issue.update(issue_params)
      redirect_to conflict_issue_path(@conflict, @issue), notice: 'Issue was successfully updated.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @issue.destroy
    redirect_to conflict_path(@conflict), notice: 'Issue was successfully destroyed.'
  end

  private

  def set_conflict
    @conflict = Conflict.find(params[:conflict_id])
  end

  def set_issue
    @issue = @conflict.issues.find(params[:id])
  end

  def issue_params
    params.require(:issue).permit(:title, :priority, :compromise, :explanation, :ideal_outcome, :acceptable_outcome,
                                  :status)
  end
end
