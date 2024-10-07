# class AddReferencesToMessages < ActiveRecord::Migration[7.0]
#   # disable_ddl_transaction!
#   # def change
#   #   safety_assured do
#   #   change_table :messages do |t|
#   #     t.references :negotiation, null: false, foreign_key: true
#   #     t.references :user, null: false, foreign_key: true
#   #   end
#   # end
#   # end

#   disable_ddl_transaction!

#   def change
#     safety_assured do
#       add_reference :messages, :negotiation, null: false, foreign_key: true, index: { algorithm: :concurrently }
#       add_reference :messages, :negotiation, null: false, index: {algorithm: :concurrently}

#       add_reference :messages, :user, null: false, foreign_key: true, index: { algorithm: :concurrently }
#     end
#   end
# end

class AddReferencesToMessages < ActiveRecord::Migration[7.0]
  disable_ddl_transaction!

  def change
    add_reference :messages, :negotiation, null: false, index: { algorithm: :concurrently }
    add_reference :messages, :user, null: false, index: { algorithm: :concurrently }
  end
end