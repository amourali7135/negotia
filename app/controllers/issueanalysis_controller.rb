class IssueAnalysesController < ApplicationController
  before_action :set_practice_session
  before_action :set_issue, only: %i[new create]
  before_action :set_issue_analysis, only: %i[show edit update address skip]

  def show
  end

  def new
    @issue_analysis = @practice_session.issue_analyses.build(issue: @issue)
  end

  def create
    @issue_analysis = @practice_session.issue_analyses.build(issue_analysis_params)
    @issue_analysis.issue = @issue

    if @issue_analysis.save
      redirect_to [@practice_session, @issue_analysis], notice: 'Issue analysis was successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @issue_analysis.update(issue_analysis_params)
      redirect_to [@practice_session, @issue_analysis], notice: 'Issue analysis was successfully updated.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def address
    satisfaction_level = params[:satisfaction_level].to_i
    if @issue_analysis.address!(satisfaction_level)
      redirect_to [@practice_session, @issue_analysis], notice: 'Issue has been marked as addressed.'
    else
      redirect_to [@practice_session, @issue_analysis], alert: 'Failed to mark issue as addressed.'
    end
  end

  def skip
    if @issue_analysis.skip!
      redirect_to [@practice_session, @issue_analysis], notice: 'Issue has been marked as skipped.'
    else
      redirect_to [@practice_session, @issue_analysis], alert: 'Failed to mark issue as skipped.'
    end
  end

  private

  def set_practice_session
    @practice_session = current_user.practice_sessions.find(params[:practice_session_id])
  end

  def set_issue
    @issue = @practice_session.conflict.issues.find(params[:issue_id])
  end

  def set_issue_analysis
    @issue_analysis = @practice_session.issue_analyses.find(params[:id])
  end

  def issue_analysis_params
    params.require(:issue_analysis).permit(:alternative_solutions, :possible_solutions, :best_alternative,
                                           :worst_alternative, :desired_outcome, :minimum_acceptable_outcome,
                                           :importance, :difficulty, :notes, :is_flexible)
  end
end
