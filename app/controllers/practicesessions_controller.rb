class PracticesessionsController < ApplicationController
  # def set something here
  def index
    @conflict = current_user.conflicts.find(params[:conflict_id])
    @practice_sessions = @conflict.practice_sessions.includes(:session_outcome).order(created_at: :desc)
  end

  def show
    @practice_session = current_user.practice_sessions.find(params[:id])
    @practice_issues = @practice_session.practice_issues.includes(:issue).order(:created_at)
  end

  def new
    @conflict = current_user.conflicts.find(params[:conflict_id])
    @practice_session = @conflict.practice_sessions.build(user: current_user)
  end

  def create
    @conflict = current_user.conflicts.find(params[:conflict_id])
    @practice_session = @conflict.practice_sessions.build(practice_session_params)
    @practice_session.user = current_user

    if @practice_session.save
      CreatePracticeIssuesJob.perform_later(@practice_session.id)
      redirect_to [@conflict, @practice_session], notice: 'Practice session started!'
    else
      render :new
    end
  end

  private

  def practice_session_params
    params.require(:practice_session).permit(:status)
  end
end
