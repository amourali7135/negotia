class IssueanalysisController < ApplicationController
  before_action :set_issue
  before_action :set_issue_analysis, only: %i[show edit update]

  def show
  end

  def new
    @issue_analysis = @issue.issue_analyses.build(user: current_user)
  end

  def create
    @issue_analysis = @issue.issue_analyses.build(issue_analysis_params)
    @issue_analysis.user = current_user

    if @issue_analysis.save
      redirect_to [@issue.conflict, @issue, @issue_analysis], notice: 'Issue analysis was successfully created.'
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @issue_analysis.update(issue_analysis_params)
      redirect_to [@issue.conflict, @issue, @issue_analysis], notice: 'Issue analysis was successfully updated.'
    else
      render :edit
    end
  end

  private

  def set_issue
    @issue = Issue.find(params[:issue_id])
  end

  def set_issue_analysis
    @issue_analysis = @issue.issue_analyses.find_by(user: current_user)
  end

  def issue_analysis_params
    params.require(:issue_analysis).permit(:interests, :possible_solutions, :best_alternative, :worst_alternative,
                                           :ideal_outcome, :acceptable_outcome, :importance, :difficulty, :notes)
  end
end
