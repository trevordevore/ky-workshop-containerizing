# EYK deployable application

## Introduction

This is a basic spree application that can be deployed on Engine Yard Kontainers. This demo spree application is designed to show how an existing application deployed on EYCloud can also be deployed on Engine Yard Kontainers, without changing the application code.


## Application Components

The application consists of: 
* the spree code
* a background task named `RandomizePricesWorker`

We have selected `sidekiq` to run the tasks. The task `RandomizePricesWorker` updates the prices of the products in a random manner. 

## Required resources

The application will need a database and redis for sidekiq. These resources are packed in a `solo` instance running on EYCloud.


### Create the application

Create the application via:

```
eyk apps:create <app_name> --remote=workshop-app-<app_name>
```


### EYK Configuration

First set the required configuration:

```
eyk config:set RAKE_ENV=development RAILS_ENV=development EYCLOUDORKY=KontainerYard REDIS_URL=redis://<redis_ip>:6379/0 DOCKER_BUILD_ARGS='{"DEIS_DOCKER_BUILD_ARGS_ENABLED":"1","db_yml_database":"<dbname>","db_yml_username":"<dbusername>","db_yml_password":"<dbpassword>","db_yml_host":"<dbhost>", "RAILS_ENV":"development"}' --app=ig-workshop-app
```


## Run background tasks

You can also create some tasks to be executed via the sidekiq workers:

         

```
RANDOMIZER_JOB_COUNT=3 bundle exec rake apptask:generate
```


