class AddPracticeSessionToPracticeSessionOutcomes < ActiveRecord::Migration[7.0]
  disable_ddl_transaction!

  def change
    ActiveRecord::Base.connection.execute("SET lock_timeout TO '10s'")
    add_reference :practice_session_outcomes, :practice_session, 
      null: false, 
      index: { algorithm: :concurrently }
  end
end