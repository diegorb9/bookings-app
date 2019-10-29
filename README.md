## Project setup
### Pre Requirements
* Linux / Mac OSX
* [Ruby 2.6.5](https://www.ruby-lang.org)
* [PostgreSQL 10.9](https://www.postgresql.org)
* [Bundler gem](https://github.com/bundler/bundler)
* [Chromedriver](https://sites.google.com/a/chromium.org/chromedriver/home)

### Install gems and dependencies

    $ bundle install
    $ gem install foreman
    $ npm -g install chromedriver

### Create database

    $ rails db:create

### Running the server

    $ foreman start

### Running the test suite

1. Prepare the test database (if not created earlier):

        $ rails db:test:prepare

2. Run the test suite:

        $ COVERAGE=true rspec

4. Check the coverage result at:

        $ open ./coverage/index.html
