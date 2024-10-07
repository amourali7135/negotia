# class AddReferencesToProposals < ActiveRecord::Migration[7.0]
#   def change
#     change_table :proposals do |t|
#       t.references :negotiation, null: false, foreign_key: true
#       t.references :proposed_by, null: false, foreign_key: { to_table: :users }
#       t.references :issue, foreign_key: true
#     end
#   end
# end

# class AddReferencesToProposals < ActiveRecord::Migration[7.0]
#   disable_ddl_transaction!

#   def change
#     safety_assured do
#       add_reference :proposals, :negotiation, null: false, foreign_key: true, index: { algorithm: :concurrently }
#       add_reference :proposals, :proposed_by, null: false, foreign_key: { to_table: :users }, index: { algorithm: :concurrently }
#       add_reference :proposals, :issue, foreign_key: true, index: { algorithm: :concurrently }
#     end
#   end
# end

class AddReferencesToProposals < ActiveRecord::Migration[7.0]
  disable_ddl_transaction!

  def change
    add_reference :proposals, :negotiation, null: false, index: { algorithm: :concurrently }
    add_reference :proposals, :proposed_by, null: false, index: { algorithm: :concurrently }
    add_reference :proposals, :issue, index: { algorithm: :concurrently }
  end
end


