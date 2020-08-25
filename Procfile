#web: AUTO_ACCEPT=1 bundle exec rake db:seed && AUTO_ACCEPT=1 bundle exec rake spree_sample:load && bundle exec rails server -b 0.0.0.0
web: bundle exec rails server -b 0.0.0.0
migration: ./ky-specific/migration/db-migrate.sh
sidekiq: bundle exec sidekiq -C config/sidekiq.yml
