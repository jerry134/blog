require "bundler/capistrano"
require 'capistrano-rbenv'
require 'capistrano-unicorn'

server "198.199.86.209", :web, :app, :db, primary: true

set :application, "blog"
set :user, "ruby"
set :deploy_to, "/home/#{user}/apps/#{application}"
set :deploy_via, :copy#remote_cache
set :use_sudo, false
set :unicorn_binary, 'unicorn_rails'

#set :scm, "git"
#set :repository, "git@github.com:jerry134/#{application}.git"
set :repository, '.'#"https://github.com/jerry134/#{application}.git"
#set :branch, "master"

default_run_options[:pty] = true
ssh_options[:forward_agent] = true

after "deploy", "deploy:cleanup" # keep only the last 5 releases
after 'deploy:restart', 'unicorn:reload'
after 'deploy:restart', 'unicorn:restart'

namespace :deploy do
  #%w[start stop restart].each do |command|
    #desc "#{command} unicorn server"
    #task command, roles: :app, except: {no_release: true} do
      #run "/etc/init.d/unicorn_#{application} #{command}"
    #end
  #end

   task :start do 
     run "unicorn_rails -c #{release_path}/config/unicorn.rb -E production -D"
   end
   task :stop do
     run "ps aux | grep unicorn | grep -v grep | awk '{print $2}' | xargs kill -s 9"
   end
   task :restart do
     run "ps aux | grep unicorn | grep -v grep | awk '{print $2}' | xargs kill -s 9"
     run "unicorn_rails -c #{release_path}/config/unicorn.rb -E production -D"
   end

  #task :setup_config, roles: :app do
    #sudo "ln -nfs #{current_path}/config/nginx.conf /etc/nginx/sites-enabled/#{application}"
    #sudo "ln -nfs #{current_path}/config/unicorn_init.sh /etc/init.d/unicorn_#{application}"
    #run "mkdir -p #{shared_path}/config"
    #put File.read("config/database.example.yml"), "#{shared_path}/config/database.yml"
    #puts "Now edit the config files in #{shared_path}."
  #end
  #after "deploy:setup", "deploy:setup_config"

  task :symlink_config, roles: :app do
    run "ln -nfs #{shared_path}/config/database.yml #{release_path}/config/database.yml"
  end
  after "deploy:finalize_update", "deploy:symlink_config"

  #desc "Make sure local git is in sync with remote."
  #task :check_revision, roles: :web do
    #unless `git rev-parse HEAD` == `git rev-parse origin/master`
      #puts "WARNING: HEAD is not the same as origin/master"
      #puts "Run `git push` to sync changes."
      #exit
    #end
  #end
  #before "deploy", "deploy:check_revision"
end
