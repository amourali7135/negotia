class PracticeSessionOutcomesController < ApplicationController
  before_action :set_practice_session
  before_action :ensure_practice_session_not_completed, only: %i[new create]  # Claude rec, hot damn

  def new
    @practice_session_outcome = @practice_session.build_practice_session_outcome
    # Not sure which one is correct.  Test later and see.
    # @practice_session_outcome = @practice_session.build_outcome
  end

  def create
    @practice_session_outcome = @practice_session.build_practice_session_outcome(practice_session_outcome_params)
    # Not sure which one is correct.  Test later and see.
    # @practice_session_outcome = @practice_session.build_outcome(practice_session_outcome_params)

    if @practice_session_outcome.save
      redirect_to [@practice_session.conflict, @practice_session],
                  notice: 'Practice session outcome recorded successfully.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def set_practice_session
    @practice_session = current_user.practice_sessions.find(params[:practice_session_id])
  end

  def practice_session_outcome_params
    params.require(:practice_session_outcome).permit(:overall_result, :satisfaction_level, :lessons_learned,
                                                     :next_steps, :notes)
  end

  def ensure_practice_session_not_completed
    return unless @practice_session.completed?

    redirect_to [@practice_session.conflict, @practice_session],
                alert: 'This practice session has already been completed.'
  end
end
