# config valid only for current version of Capistrano
lock "3.7.2"

set :application, 's3'
set :repo_url, 'https://github.com/samuels410/s3'
set :deploy_to, '/var/deploy/capistrano/s3'
set :passenger_user, 'canvasuser'
set :pty, true
set :linked_files, %w{config/database.yml config/secrets.yml}
set :linked_dirs, %w{log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system}
set :keep_releases, 5

set :bundle_flags, "--deployment"

set :output, 'log/cron.log'

set :passenger_roles, :app
set :passenger_restart_runner, :sequence
set :passenger_restart_wait, 5
set :passenger_restart_limit, 2
set :passenger_restart_with_sudo, true
set :passenger_environment_variables, {}
set :passenger_restart_command, 'passenger-config restart-app'
set :passenger_restart_options, -> { "#{deploy_to} --ignore-app-not-running" }


namespace :deploy do

  desc "change permission to passenger_user "
  task :canvasuser_permission do
    on roles(:app) do
      within "#{release_path}" do
        with rails_env: "#{fetch(:stage)}" do
          sudo "chown -R #{fetch(:passenger_user)} #{release_path}/"
          sudo "chown -R #{fetch(:passenger_user)} #{release_path}/log/"
          sudo "chmod 777 -R #{release_path}/tmp/cache"
        end
      end
    end
  end
end

after :deploy, 'deploy:canvasuser_permission'