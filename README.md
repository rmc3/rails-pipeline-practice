# rails-pipeline-practice

This repository contains a Rails application intended as a simple testing environment with unit and integration tests for practicing CI/CD pipeline practices.

## Prerequisites

- Ruby 2.4
- bundler `gem install bundler`

## Running in a development environment locally

Install gems

```
bundle install --with development
```

Start the Puma server

```
rails server
```

The application should come up and be available at http://localhost:3030

## Running tests

Install gems

```
bundle install --with test
```

Run tests

```
rake test
```
