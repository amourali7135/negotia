class PracticesessionoutcomesController < ApplicationController
  before_action :set_practice_session

  def new
    @session_outcome = @practice_session.build_session_outcome
  end

  def create
    @session_outcome = @practice_session.build_session_outcome(session_outcome_params)

    if @session_outcome.save
      @practice_session.update(status: :completed)
      redirect_to [@practice_session.conflict, @practice_session], notice: 'Session outcome recorded successfully.'
    else
      render :new
    end
  end

  private

  def set_practice_session
    @practice_session = current_user.practice_sessions.find(params[:practice_session_id])
  end

  def session_outcome_params
    params.require(:session_outcome).permit(:overall_result, :satisfaction_level, :lessons_learned, :next_steps)
  end
end
