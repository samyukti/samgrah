require 'active_record'

db_namespace = namespace :db do
  desc 'Load the seed data from db/history.rb'
  task :history do
    db_namespace['abort_if_pending_migrations'].invoke
    seed_file = 'db/history.rb'
    load(seed_file)
  end
end
