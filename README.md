# EYCloud deployable application

## Introduction

This is a basic spree application that can be deployed on EYCloud.
This demo spree application is designed to show how an existing application deployed on EYCloud can also be deployed on KontainerYard, without changing the application code.

## Application Components

The application consists of: 
* the spree code
* a background task named `RandomizePricesWorker`

We have selected `sidekiq` to run the tasks. The task `RandomizePricesWorker` updates the prices of the products in a random manner. 

## Required resources

The application will need a database and redis for sidekiq. These resources are packed in a `solo` instance. 

### EYCloud

In the EYCloud case the resources are accessible since the application code and the services (database + redis) do run in the same instance. We set the environment to `development` so that the relevant configuration will be used.

We will need to setup `sidekiq` and `redis` through chef custom recipes.


### EYCloud Environment variables

The application expects some environment variables that will show where it runs:

* `EYCLOUDORKY` = `EYCloud`


## Deploy the application

### EYCloud deployment 
Just click the Deploy button 

## Initialize the application

The spree application has some migrations and test data which will populate the database. We can login to the EYCloud instance and run:

```
bundle exec rails g spree:install --migrate=true --seed=true
```

Now the test data are in place. 

## Run background tasks

You can also create some tasks to be executed via the sidekiq workers:

         

```
RANDOMIZER_JOB_COUNT=3 bundle exec rake apptask:generate
```


