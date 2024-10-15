class ComparisonController < ApplicationController
  def index
    @conflict = current_user.conflicts.find(params[:conflict_id])
    @practice_sessions = @conflict.practice_sessions.includes(:session_outcome,
                                                              :practice_issues).order(created_at: :desc)
  end
end
