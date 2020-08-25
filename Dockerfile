FROM engineyard/kontainers:ruby-2.5-v1.0.0

# This will be needed by spree
RUN apt-get install -y imagemagick


# Configure the main working directory. This is the base
# directory used in any further RUN, COPY, and ENTRYPOINT
# commands.
RUN mkdir -p /app
WORKDIR /app

ARG RAILS_ENV
# Copy the Gemfile and Gemfile.lock and bundle
COPY Gemfile ./
COPY Gemfile.lock ./
RUN bundle install --jobs 20 --retry 5

# Copy the main application.
COPY . ./

# Create the needed config files on docker build time
ARG db_yml_database
ARG db_yml_username
ARG db_yml_password
ARG db_yml_host
RUN erb -T - ./ky-specific/config/database.yml.erb > config/database.yml
RUN cp ./ky-specific/config/sidekiq.yml config/sidekiq.yml

# Make the migration script runable
RUN chmod +x ky-specific/migration/db-migrate.sh


# Precompile Rails assets
RUN bundle exec rake assets:precompile


# Expose port 5000 to the Docker host, so we can access it
# from the outside. This is the same as the one set with
# `deis config:set PORT 5000`
EXPOSE 5000

# The main command to run when the container starts. Also
# tell the Rails dev server to bind to all interfaces by
# default.
CMD sleep 3600
