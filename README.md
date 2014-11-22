# Grezha
![build status](https://travis-ci.org/shanear/grezha.svg)

Grezha is a CRM specialized for service-based organizations.

With Grezha, you can:
* __Easily find and record client information__.
* __Record communication with your clients__  using Connections, which represent a phone call, an in person meeting, an email, or text. See a timeline of the connections you've made with each client.
* __See your impact__ through a dashboard report showing the number of the connections your organization is making with clients.
* __Work offline__. Grezha uses HTML5 to save the entire application in your browser. Data added offline will be automatically synced with the server when reconnected. 

Grezha is currently a work in progress, and our development is directed by our users. So if you think Grezha would be helpful to your organization, let me know! Send me an email at shane@grezha.org

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
organization, let me know! Send me a shoutout at shane@grezha.org

