class PracticeSessionsController < ApplicationController
  before_action :set_conflict, only: %i[index new create]
  before_action :set_practice_session, only: %i[show update complete]

  def index
    @practice_sessions = @conflict.practice_sessions.includes(:practice_session_outcome).order(created_at: :desc)
  end

  def show
    @practice_issues = @practice_session.issue_analyses.includes(:issue).order(:created_at)
  end

  def new
    @practice_session = @conflict.practice_sessions.build(user: current_user)
  end

  def create
    # @practice_session = @conflict.practice_sessions.build(practice_session_params.merge(user: current_user))
    @practice_session = @conflict.practice_sessions.build(practice_session_params)
    @practice_session.user = current_user
    @practice_session.start! # Jesus, Claude's teaching me a lot!
    if @practice_session.save
      redirect_to [@conflict, @practice_session], notice: 'Practice session started!'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @practice_session.update(practice_session_params)
      redirect_to [@conflict, @practice_session], notice: 'Practice session updated successfully.'
    else
      render :show, status: :unprocessable_entity
    end
  end

  def complete
    if @practice_session.complete!
      redirect_to [@conflict, @practice_session], notice: 'Practice session completed successfully.'
    else
      redirect_to [@conflict, @practice_session], alert: 'Unable to complete practice session.'
    end
  end

  private

  def set_conflict
    @conflict = current_user.conflicts.find(params[:conflict_id])
  end

  def set_practice_session
    @practice_session = current_user.practice_sessions.find(params[:id])
    @conflict = @practice_session.conflict
  end

  def practice_session_params
    params.require(:practice_session).permit(:status)
  end
end
