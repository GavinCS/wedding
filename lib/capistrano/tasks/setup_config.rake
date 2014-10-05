  desc "Tasks for first setting up the app"
  task :setup_config  do
    on roles(:app) do
      #cap doesnt do this, so lets tell it to do it
      #create the database.yml on the server
      execute :sudo, :chown, "-R #{fetch(:user)}:#{fetch(:user)} /var/www/gavinandcarolene"
      execute :mkdir, "-p #{shared_path}/config/"
      execute :touch, "#{shared_path}/config/database.yml "
      puts "Now edit the database config in #{shared_path}."
      exit 1
    end
  end