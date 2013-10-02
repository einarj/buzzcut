# Resque tasks
require 'resque/tasks'
require 'resque_scheduler/tasks'

namespace :resque do
  desc "Setup the resque environment and jobs"
  task :setup => :environment do
    require 'resque'
    require 'resque_scheduler'
    require 'resque/scheduler'

    # you probably already have this somewhere
    Resque.redis = 'localhost:6379'

    # The schedule doesn't need to be stored in a YAML, it just needs to
    # be a hash.  YAML is usually the easiest.
    Resque::Scheduler.dynamic = true
    Resque.schedule = YAML.load_file('config/buzzcut_resque_schedule.yml')

  end

end
