web: bundle exec puma -C config/puma.rb
release: bundle exec rails db:migrate
worker: bundle exec bin/delayed_job -n4 run
