class AddProposalToProposalResponses < ActiveRecord::Migration[7.0]
  disable_ddl_transaction!

  def change
    ActiveRecord::Base.connection.execute("SET lock_timeout TO '10s'")
    add_reference :proposal_responses, :proposal, null: false, index: { algorithm: :concurrently }
  end
end