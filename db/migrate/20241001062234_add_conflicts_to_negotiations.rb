# class AddConflictsToNegotiations < ActiveRecord::Migration[7.0]
#   # safety_assured {
#   def change
#     change_table :negotiations do |t|
#     # t.references :conflict2, foreign_key: { to_table: :conflicts }
#     # add_reference :negotiations, :conflict1, foreign_key: { to_table: :conflicts }, null: false
#     # add_reference :negotiations, :conflict2, foreign_key: { to_table: :conflicts }, null: true
#     # add_column :negotiations, :conflict2_id, :bigint
#     # add_foreign_key :negotiations, :conflicts, column: :conflict2_id
#     # add_index :negotiations, :conflict2_id
#     #
#     t.references :conflict1, null: false, foreign_key: { to_table: :conflicts }
#     t.references :conflict2, foreign_key: { to_table: :conflicts }
#     # end
#     end
#   end
# # }
# end


class AddConflictsToNegotiations < ActiveRecord::Migration[7.0]
  disable_ddl_transaction!

  def change
    safety_assured do
      # add_reference :negotiations, :conflict1, null: false, foreign_key: { to_table: :conflicts }, index: { algorithm: :concurrently }
      add_reference :negotiations, :conflict1, null: false, index: {algorithm: :concurrently}
      # add_reference :negotiations, :conflict2, foreign_key: { to_table: :conflicts }, index: { algorithm: :concurrently }
      add_reference :negotiations, :conflict2, null: false, index: {algorithm: :concurrently}
    end
  end
end

