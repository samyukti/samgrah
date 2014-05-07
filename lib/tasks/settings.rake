require 'active_record'

db_namespace = namespace :db do
  desc 'Load the seed data from db/settings.rb'
  task :settings do
    db_namespace['abort_if_pending_migrations'].invoke
    seed_file = 'db/settings.rb'
    load(seed_file)
  end
end
