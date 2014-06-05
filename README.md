# Grezha
![build status](https://travis-ci.org/shanear/grezha.svg)

Grezha is a field note taking application for rescuing and caring for people
involved in prostitution & sex trafficking.

* Keep up with the birthdays, needs, and the times you've connected with
  your contacts.
* Also record information about vehicles you see in the field.


## Getting Started

Grezha is built using Ruby on Rails, Ember.js, and PostgreSQL. You can setup the
project by installing PostgreSQL, RVM, and following the standard rails setup
process.

### Project Setup

1) Clone the project.
```
git clone git@github.com:shanear/grezha.git
```

2) Install rvm & use it to install the ruby version specified in Gemfile.
```
rvm install ruby-1.9.3-p545
```

3) Install bundled gems
```
bundle install
```

### Database Setup

First install PostgreSQL. You can install it easily via homebrew:
```
brew install postgresql
```

NOTE: There may be more to setting up postgres... You'll need to look elsewhere on the internet for guidance here.

Once PostgreSQL is setup, you should open a database session with the admin user and create the application user, `grezha`:
```sql
CREATE USER grezha CREATEDB;
```

Then you can create the databases, load the tables, and load some seed data by running
the commands:
```
rake db:create
rake db:schema:load
rake db:seed
```

## Want to use it?

If you're interested in helping or think Grezha would be helpful to your
organization, let me know! Send me a shoutout at shane1337@gmail.com

