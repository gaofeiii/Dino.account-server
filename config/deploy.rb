$:.unshift(File.expand_path('./lib', ENV['rvm_path']))
require "rvm/capistrano"

set :rvm_ruby_string, "1.9.3@rails321"
set :rvm_type, :user

set :application, "accounts"
set :user, "xiaojuhua"
set :password, "really"
set :runner, "xiaojuhua"
set :deploy_to, "/var/www/apps/#{application}"
set :deploy_via, :remote_cache
set :use_sudo, false
set :keep_releases, 5

set :repository,  "git@96.126.121.100:/git/accounts.git"
set :scm, :git
set :branch, "master"

role :web, "96.126.121.100"                        # Your HTTP server, Apache/etc
role :app, "96.126.121.100"                          # This may be the same as your `Web` server
role :db,  "96.126.121.100", :primary => true # This is where Rails migrations will run
# role :db,  "your slave db-server here"

namespace :unicorn do
  desc "start unicorn"
  task :start do
    run "unicorn -c #{current_path}/config/unicorn.rb -E production -D"
  end
  
  desc "stop unicorn"
  task :stop do
    run "kill -Q cat `#{shared_path}/pids/unicorn.pid`"
  end
end