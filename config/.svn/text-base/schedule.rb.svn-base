# Use this file to easily define all of your cron jobs.
#
# It's helpful, but not entirely necessary to understand cron before proceeding.
# http://en.wikipedia.org/wiki/Cron

# Example:
#
# set :output, "/path/to/my/cron_log.log"
#
# every 2.hours do
#   command "/usr/bin/some_great_command"
#   runner "MyModel.some_method"
#   rake "some:great:rake:task"
# end
#
# every 4.days do
#   runner "AnotherModel.prune_old_records"
# end

# Learn more: http://github.com/javan/whenever


set :environment, 'production'

set :output, "#{path}/log/cron.log"

#every 2.minutes do
#  rake "task_values", environment => "development"
#end

every 1.day, :at => '2 am' do
  runner "CompanyDashboard.generate_project_and_company_dashboards_from_cron(Date.today)"
end

