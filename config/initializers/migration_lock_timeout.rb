# # To set up a more migration-specific lock timeout, you can add a new initializer specifically for migrations. This will ensure that the timeout is applied only when migrations run and doesn’t interfere with other tasks (like database creation or dropping). Here’s how to do it:

# #   Step 1: Create an Initializer for the Migration Lock Timeout
# #   In config/initializers, create a new file named migration_lock_timeout.rb. This file will set the lock timeout only when running migrations:
# #   Explanation
# # Condition Check: if defined?(ActiveRecord::Migration) && ActiveRecord::Base.connected? ensures that this initializer only runs when the ActiveRecord::Migration module is defined, and a database connection is present. This avoids issues with commands like rails db:drop or rails db:create which may run without an existing database.

# # Prepending migrate Method: By prepending a custom module to the migrate method, the lock timeout is set only when migrations are running, rather than globally across the app.

# # With this initializer, your Rails application will apply the lock timeout of 10 seconds only during migrations without affecting other commands. Let me know if you encounter any issues with this setup!


# # if defined?(ActiveRecord::Migration) && ActiveRecord::Base.connected?
# #   ActiveRecord::Migration.class_eval do
# #     # Before each migration, set the lock timeout to 10 seconds
# #     ActiveRecord::Migration.prepend(Module.new do
# #       def migrate(*args)
# #         ActiveRecord::Base.connection.execute("SET lock_timeout TO '10s'")
# #         super
# #       end
# #     end)
# #   end
# # end

# # config/initializers/lock_timeout.rb
# Rails.application.config.after_initialize do
#   ActiveRecord::Base.connection.execute("SET lock_timeout TO '10s'")
#   # puts "Lock timeout set to 10s"
# end

