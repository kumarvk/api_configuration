require_relative 'app_call'

namespace :db do
  desc "Create the database"
  task :create do
    ActiveRecord::Base.connection.create_database(DB_CONFIGURATION["database"])
    puts "Database created."
  end

  desc "Run migrations"
  task :migrate do
    ActiveRecord::Migrator.migrate('db/migrate', 1)
    puts "Database migrated."
  end

  desc "Drop the database"
  task :drop do
    ActiveRecord::Base.connection.drop_database(DB_CONFIGURATION["database"])
    puts "Database deleted."
  end
end