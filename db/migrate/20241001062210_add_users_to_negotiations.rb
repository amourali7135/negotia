# # class AddUsersToNegotiations < ActiveRecord::Migration[7.0]
# #   # disable_ddl_transaction!
# #   def change
# #     safety_assured {
# #     change_table :negotiations do |t|
# #       t.references :user1, null: false, foreign_key: { to_table: :users }
# #       t.references :user2, null: false, foreign_key: { to_table: :users }
# #       t.references :initiator, null: false, foreign_key: { to_table: :users } 
# #       # t.references :user2, null: false, foreign_key: { to_table: :users }
# #       # add_reference :negotiations, :user2, foreign_key: { to_table: :users }, null: false
# #       # add_column :negotiations, :user2_id, :bigint
# #       # add_foreign_key :negotiations, :users, column: :user2_id
# #       # add_index :negotiations, :user2_id
# #       #
# #     end
# #   } 
# #   end
# # end

# # class AddUsersToNegotiations < ActiveRecord::Migration[7.0]
# #   disable_ddl_transaction!

# #   def change
# #     safety_assured do
# #       add_reference :negotiations, :user1, null: false, foreign_key: { to_table: :users }
# #       add_reference :negotiations, :user2, null: false, foreign_key: { to_table: :users }
# #       add_reference :negotiations, :initiator, null: false, foreign_key: { to_table: :users }
# #     end
# #   end
# # end

class AddUsersToNegotiations < ActiveRecord::Migration[7.0]
  disable_ddl_transaction!

  def change
    add_reference :negotiations, :user1, null: false, index: {algorithm: :concurrently}
    add_reference :negotiations, :user2, null: false, index: {algorithm: :concurrently}
    add_reference :negotiations, :initiator, null: false, index: {algorithm: :concurrently}
  end
end
