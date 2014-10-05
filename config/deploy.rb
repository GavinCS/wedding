# Ensure that bundle is used for rake tasks
SSHKit.config.command_map[:rake] = "bundle exec rake"
# config valid only for Capistrano 3.1
lock '3.2.1'

set :application, 'gavinandcarolene.co.za'
set :rails_env, 'production'
set :repo_url, 'git@github.com:GavinCS/wedding.git'

# Default branch is :master
# ask :branch, proc { `git rev-parse --abbrev-ref HEAD`.chomp }.call

# Default deploy_to directory is /var/www/my_app
set :deploy_to, '/var/www/gavinandcarolene/'
set :deploy_via, :remote_cache

# Default value for :linked_files is []
set :linked_files, %w{config/database.yml}

# Default value for linked_dirs is []
set :linked_dirs, %w{bin log tmp/pids tmp/cache tmp/sockets vendor/bundle public/uploads}

# Default value for default_env is {}
#set :default_env, :production

## Default value for keep_releases is 5
set :keep_releases, 5

set(:config_files, %w(database.example.yml))

namespace :deploy do

  desc "Change ownership to deployer"
  task :change_ownership  do
    on roles(:app) do
      execute :sudo, :chown, "-R #{fetch(:user)}:#{fetch(:user)} /var/www/gavinandcarolene"
    end
  end


  before "deploy:starting", "deploy:change_ownership"

  desc "Change ownership from deployer to www-data"
  task :reset_ownership do
    on roles(:app) do
      execute :sudo, :chown, "-R www-data:www-data /var/www/gavinandcarolene"
    end
  end

  after "deploy:finished", "deploy:reset_ownership"

  desc 'Restart application'
  task :restart do
    on roles(:app), in: :sequence, wait: 5 do
      # Your restart mechanism here, for example:
      # execute :touch, release_path.join('tmp/restart.txt')
    end
  end

  after :publishing, :restart

  after :restart, :clear_cache do
    on roles(:web), in: :groups, limit: 3, wait: 10 do
      # Here we can do anything such as:
      # within release_path do
      #   execute :rake, 'cache:clear'
      # end
    end
  end

end
