# TwoHomes - API

## Overview
TwoHomes is a set of communication tools to make co-parenting just a little bit easier. TwoHomes reduces divorce conflict by providing a centralized communication platform that can be easily audited by legal professionals.

![alt text](https://cloud.githubusercontent.com/assets/4949247/17075360/3a60931c-5046-11e6-9477-feea8fec2adf.png "Chat Interface")

## Tech Stack
* Rails API | Backend - (Web Application Framework)
* EmberJS | Frontend  - (JavaScript Web Framework)
* Firebase | Message Data Store - (Realtime Database)
* Postgres | Application Data Store - (Database)
* JSON API Resources | JSON API  - (API Specification)
* Doorkeeper | OAuth - (Authentication)

## API Documentation
 After following the Developer Enviroment Setup (below) you can find the application API documentation at [http://localhost:4200](http://localhost:4200)

## Developer Environment Setup

This setup assumes you are using a recent version of OS X and have [Homebrew](http://brew.sh/) installed.

1. Clone this repo
2. Navigate to the repo on your local machine
3. Install [rbenv](https://github.com/sstephenson/rbenv)
4. Install Ruby by entering `rbenv install $(cat ./.ruby-version)`. This installs the version of Ruby that is specified in `.ruby-version` in this repo.
5. Verify the correct version of Ruby is installed by entering `rbenv version`. The output should be something like `2.2.3`. Additionally, verify that `ruby --version` output is something like `ruby 2.2.3p95 (2015-04-13 revision 50295) [x86_64-darwin14]`
6. Install [Bundler](http://bundler.io/) by entering `gem install bundler` and then run `rbenv rehash`
7. Install application dependencies by entering `bundle install`
8. Install PostgreSQL using Homebrew by entering `brew install postgresql` and then initialize PostgreSQL `postgres -D /usr/local/var/postgres`
9. Then initialize the PostgreSQL database by entering `pg_ctl initdb -D /usr/local/pgsql/data`
10. Create the application databases by entering `bundle exec rake db:create:all`
11. Migrate the application databases by entering `bundle exec rake db:migrate RAILS_ENV=development` and `bundle exec rake db:migrate RAILS_ENV=test`
12. Start the Ruby on Rails server by entering bin/rails server
13. Start the Ember server by following the instructions in the TwoHomes - Client readme.
14. Open a browser on your local machine and navigate to [http://localhost:4200](http://localhost:4200) and enjoy!

