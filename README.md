# rails-pipeline-practice

This repository contains a Rails application intended as a simple testing environment with unit and integration tests for practicing CI/CD pipeline practices.

## Prerequisites

Running locally

- Ruby 2.4
- bundler `gem install bundler`

Docker

- Docker
- Docker Compose

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

## Jenkins Pipeline

This section describes how to set up and run the Jenkins pipeline.

### Set up ECS environment

This process assumes you'll be deploying images to an Elastic Container Repository. The CloudFormation template in `deployment/cloudformation/ecs-environment.yaml` can automate creating an ECR and ECS cluster, along with IAM policies and profiles required for Jenkins to work with them.

### Install Jenkins

For this example, we used the Bitnami Jenkins EC2 AMI. If deploying on EC2, you can attach the instance profile created by the CloudFormation template in `deployment/cloudformation/ecs-environment.yaml` to give the instance the necessary permissions to deploy to your ECR repository.

### Install AWS CLI

Install the AWS CLI tools through your favorite method.

### Install Docker

Install docker and add the Jenkins user to the `docker` group.

```
apt-get install -y docker
usermod -a -G docker tomcat
```

Restart Jenkins fully (all the way down, not Jenkins' built in restart, as this seems to be necessary to pick up the group change)

### Create the pipeline

Create a pipeline with the example configuration in `deployment/jenkins/pipeline`. Adjust AWS-related parameters as necessary for your environment.

## Acknowledgements

This exercise draws heavily from Michael Hartl's [Ruby on Rails Tutorial](https://www.railstutorial.org/book), which was incredibly helpful.
