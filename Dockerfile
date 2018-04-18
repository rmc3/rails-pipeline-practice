# Use the barebones version of Ruby 2.2.3.
FROM ruby:2.4.1-slim

# Optionally set a maintainer name to let people know who made this image.
MAINTAINER Richard Chatterton <richard.chatterton@stelligent.com>

# Install dependencies:
# - build-essential: To ensure certain gems can be compiled
# - nodejs/npm/yarn: To allow for javascript compilation
# - libmysqlclient-dev: To support mysql2 gem
# - libsqlite3-dev: To support sqlite in testing mode
RUN apt-get update && apt-get install -qq -y build-essential nodejs npm libmysqlclient-dev libsqlite3-dev --fix-missing --no-install-recommends
RUN npm install yarn -g

RUN adduser rpp

# Set an environment variable to store where the app is installed to inside
# of the Docker image.
ENV INSTALL_PATH /rails-pipeline-practice
RUN mkdir -p $INSTALL_PATH

# This sets the context of where commands will be ran in and is documented
# on Docker's website extensively.
WORKDIR $INSTALL_PATH

# Adds Aurora RDS certs for SSL connections
ADD https://s3.amazonaws.com/rds-downloads/rds-combined-ca-bundle.pem /aurora/rds-combined-ca-bundle.pem

# Ensure gems are cached and only get updated when they change. This will
# drastically increase build times when your gems do not change.
COPY Gemfile Gemfile
RUN bundle install

# Copy in the application code from your work station at the current directory
# over to the working directory.
COPY . .

RUN chown -R rpp:rpp $INSTALL_PATH

USER rpp

# Provide dummy data to Rails so it can pre-compile assets.
RUN bundle exec rake SECRET_TOKEN=$(rake secret) RAILS_ENV=development DB_NAME=rpp DB_HOST=localhost DB_USERNAME=rpp DB_PASSWORD=foobar assets:precompile

# Expose a volume so that nginx will be able to read in assets in production.
VOLUME ["$INSTALL_PATH/public"])

# The default command that gets ran will be to start the Puma server.
ENTRYPOINT SECRET_TOKEN=$(rake secret) bin/entrypoint.sh bundle exec rails server --no-daemon
