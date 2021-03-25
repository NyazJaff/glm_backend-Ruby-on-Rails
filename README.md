# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version
  https://devhints.io/rbenv
  
* System dependencies

* Configuration
  https://medium.com/@devontem/solved-cant-connect-to-local-mysql-server-through-socket-tmp-mysql-sock-2-f52c9c546f7
  
* Database creation
  Add to .env
  DB_HOST=localhost
  DB_USER_NAME=root
  DB_PASSWORD=root

  rake db:migrate
  
* Database initialization
  mysql.server restart
  

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions
  
  bundle exec cap production deploy # Deploy using Cap
  sudo service nginx start          # Restart nginx
  gem update --system               # Point bundler to latest installed
  RAILS_ENV=production rails c      # Access rails c, might have to run 'gem install rails' if first time

* ...
