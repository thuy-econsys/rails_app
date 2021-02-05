Notes here are for Mac OS and 



# Devise

This app limits access for new users who have successfully signed up, keeping them in an `unapproved` state until an Administrator approves them. After [setting up Devise](https://github.com/thuy-econsys/rails_app/wiki/Devise), an *approved* column was generated:
```bash
rails generate migration AddApprovedToUsers approved:boolean
```

Migration file adjusted to include `:default => false, :null => false`.
```ruby
class AddApprovedToUsers < ActiveRecord::Migration
  def change
    add_column :users, :approved, :boolean, :default => false, :null => false
  end
end
```

# CanCan

TODO after establishing an Administrator, setup **CanCan** to authorize specific pages users can access or actions they can perform.

# DB

If there's a db connection error upon starting Rails server, run `pg_ctl status` to make sure your PostgreSQL server is running. If it's not running, start it up: 
```bash
pg_ctl -D /usr/local/var/postgres -l /usr/local/var/log/postgres.log start
```

If you've gone over my Wiki for [setting up PostgreSQL](https://github.com/thuy-econsys/rails_app/wiki/PostgreSQL-Setup) and set the **PGDATA** _environment variable_, no need to include option `-D` which establishes the location of your _data directory_. Option `-l` is for establishing location of PostgreSQL server logs, but unlike option `-D` is not necessary. 

[`config/database.yml`](https://github.com/thuy-econsys/rails_app/blob/master/config/database.yml) contains configurations for your Rails project's database. It relies on _environment variables_ so in your terminal, run the following scripts, replacing the angle-bracketed values with your username, password and database: 
```bash
$ cat << EOF >> ~/.bash_profile
> export PG_USERNAME=<user_name>
> export PG_PASSWORD=<password>
> export PG_DBNAME=<db_name>
> export PG_HOST=localhost
> export PG_PORT=5432
> EOF

$ source ~/.bash_profile
```

For Windows, checkout Microsoft's documentation for [changing _environment variables_ in **PowerShell**](https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_environment_variables?view=powershell-7.1#using-and-changing-environment-variables).

Run seeding script in [`db/seeds.rb`](https://github.com/thuy-econsys/rails_app/blob/master/db/seeds.rb) to generate users to play with:
```ruby
rails db:seed
```

# Views & Styling

Very basic Bootstrap styling which needs these gems:

```gemfile
gem 'bootstrap'
gem 'jquery-rails'
gem 'jquery-turbolinks'
gem 'devise-bootstrap-views', '~> 1.0'
```

But also need to adjust `app/assets/stylesheets/application.scss`:
```css
@import "bootstrap";
```

And also added to `app/assets/javascripts/application.js`: 

```javascript
//= require jquery_ujs
//= require popper
//= require jquery3
//= require jquery.turbolinks
//= require bootstrap-sprockets
```

Normally the views generator is `rails generate devise:views` but with the gem, **devise-bootstrap-views**, run `rails generate devise:views:bootstrap_templates` instead to get some instant Bootstrap styling.

# Mailer

