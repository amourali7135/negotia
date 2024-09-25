class IssuesController < ApplicationController
  before_action :set_conflict
  before_action :set_issue, only: %i[show edit update destroy]

  def index
    @issues = @conflict.issues
  end

  def show
  end

  def new
    @conflict = Conflict.find(params[:conflict_id])
    @issue = Issue.new
  end

  def create
    @issue = Issue.new(issue_params)
    @issue.conflict = @conflict
    if @issue.save
      redirect_to conflict_issue_index(@conflict, @issue), notice: 'Issue was successfully created.'
    else
      render :new, status: :unprocessable_entity
    end

    redirect_to restaurant_path(@restaurant)
  end

  def edit
    @issue = Issue.find(params[:id])
  end

  def update
    if @issue.update(issue_params)
      redirect_to conflict_issue_path(@conflict, @issue), notice: 'Issue was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @issue.destroy
    redirect_to conflict_path(@conflict), notice: 'Issue was successfully destroyed.'
  end

  private

  def set_conflict
    @conflict = Conflict.find(params[:id])
  end

  def set_issue
    @issue = @conflict.issues.find(params[:id])
  end

  def issue_params
    params.require(:issue).permit(:title, :priority, :compromise, :explanation, :ideal_outcome, :acceptable_outcome,
                                  :status, :offer)
  end
end
