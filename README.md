# rails-pipeline-practice

This repository contains a Rails application intended as a simple testing environment with unit and integration tests for practicing CI/CD pipeline practices.

## Prerequisites

Running locally

- Ruby 2.4
- bundler `gem install bundler`

Docker

- Docker
- Docker Compose

Vagrant

- Vagrant

## Running in a development environment locally

This process will run the application in your local Ruby environment with a sqlite database.

Install gems

```
bundle install --with development
```

Start the Puma server

```
rails server
```

The application should come up and be available at http://localhost:3300

## Running tests

Install gems

```
bundle install --with test
```

Run tests

```
rake test
```

## Docker

### Building and testing in a development environment

To build and test locally, run with `RAILS_ENV=development`. This will run the application in a Docker container with a non-persistent sqlite database. See the below examples.

#### Build the image

```
docker build --tag rpp .
```

#### Run tests

```
RAILS_ENV=development docker run --entrypoint rake rpp test
```

#### Start development environment

```
RAILS_ENV=development docker run -p 3300:3000 rpp
```

The application should then be available at http://localhost:3300

## Docker Compose

The following deploys the application with a nginx reverse proxy and a MariaDB database in three Docker containers with Docker Compose.

```
RAILS_ENV=local_integration docker-compose up -V
```

Substitute with other environments as desired.

## Acknowledgements

This exercise draws heavily from Michael Hartl's [Ruby on Rails Tutorial](https://www.railstutorial.org/book), which was incredibly helpful.
