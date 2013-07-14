# $:.unshift(File.expand_path('./lib', ENV['rvm_path']))

require 'bundler/capistrano'

# Server list
@linode = "106.187.91.156"
@a001 = "50.112.84.136"
@ali001 = "42.120.23.41"
@local = "192.168.1.201"

# Deploy server
@servers = [@local]

set :rvm_ruby_string, "2.0.0@accounts"
set :rvm_type, :user
require "rvm/capistrano"

default_run_options[:pty] = true
set :user, "gaofei"
set :runner, "gaofei"
set :ssh_options,   { :forward_agent => true }
set :application, "accounts"
set :deploy_to, "/var/games/servers/#{application}"
set :deploy_via, :remote_cache
set :rails_env, :production
set :use_sudo, false
set :keep_releases, 5

set :repository,  "gitolite@192.168.1.201:dinostyle.account-server.git"
set :scm, :git
set :branch, "master"

# @servers.each do |svr|
#   role :web, svr
#   role :app, svr
#   role :db, svr, :primary => true
# end

role :web, *@servers
role :app, *@servers
role :db,  *@servers, :primary => true # This is where Rails migrations will run

# namespace :deploy do
#   %w(start stop restart).each do |action|
#     desc "unicorn:#{action}"
#     task action.to_sym do
#       find_and_execute_task("unicorn:#{action}")
#     end
#   end
# end
namespace :remote_cache do
  desc "Remove the remote cache"
  task :remove do
    run "rm -rf #{deploy_to}/shared/cached_copy"
  end
end

namespace :nginx do
  desc "Copy nginx config file to aim directory"
  task :config do
    run "sudo cp #{current_path}/config/nginx/dinosaur-account.conf /etc/nginx/conf.d/"
  end

  desc "Reload nginx"
  task :reload do
    run "sudo nginx -s reload"
  end

  desc "Restart nginx by new config file"
  task :restart do
    find_and_execute_task("nginx:config")
    find_and_execute_task("nginx:reload")
  end
end

namespace :assets do
  desc "assets:precompile"
  task :precompile, :role => :app do
    run "cd #{current_path} && bundle exec rake assets:precompile"
  end
end

namespace :rvm do
  task :trust_rvmrc do
    run "rvm rvmrc trust \#\{release_path\}"
  end
end

# 如果有rvmrc文件需要执行 trust_rvmrc
# after "deploy", "rvm:trust_rvmrc"
# after "deploy", "deploy:migrate"
# after "deploy", "assets:precompile"

namespace :unicorn do
  desc "Start unicorn"
    task :start, :roles => :app do
      run "cd #{current_path} && bundle exec unicorn -c #{current_path}/config/unicorn.rb -D -E production"
    end

    desc "Stop unicorn"
    task :stop, :roles => :app do
      run "kill -QUIT `cat #{current_path}/tmp/pids/unicorn.pid`"
      sleep(3)
    end

    desc "Restart unicorn"
    task :restart, :roles => :app do
      find_and_execute_task("unicorn:stop")
      find_and_execute_task("unicorn:start")
    end
end

namespace :puma do
  desc "Start puma"
  task :start, :roles => :app do
    run "cd #{current_path} && bundle exec puma -C #{current_path}/config/puma.rb"
  end

  task :stop, :roles => :app do
    run "sudo kill -QUIT `cat #{deploy_to}/shared/pids/puma.pid`"
  end

end

task :deploy_all do
  find_and_execute_task("deploy:cleanup")
  find_and_execute_task("deploy")
  find_and_execute_task("unicorn:restart")
end
