# Devise

```bash
rails generate devise:install
rails generate devise User
rails db:migrate
rails generate devise:views:bootstrap_templates
```

Normally the views generator is `rails generate devise:views` but there's a gem that automates Bootstrap styling to Devise templates, `devise-bootstrap-views`, so the rails generator is `rails generate devise:views:bootstrap_templates`.

# CanCan



# Styling

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

# DB

If there's a db connection error upon starting Rails server, run `pg_ctl status` to make sure your PostgreSQL server is running. If it's not running, start it up: 
```bash
pg_ctl -D /usr/local/var/postgres -l /usr/local/var/log/postgres.log start
```

If you've gone over my Wiki for [setting up PostgreSQL](https://github.com/thuy-econsys/rails_app/wiki/PostgreSQL-Setup) and set the **PGDATA** _environment variable_, no need to include option `-D` which establishes the location of your _data directory_. Option `-l` is for establishing location of PostgreSQL server logs, but unlike option `-D` is not necessary. 

```bash
psql -h $PG_HOST -U $PG_USERNAME -p $PG_PORT $PG_DBNAME
```

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

If you're on Windows, checkout Microsoft's documentation for [changing _environment variables_ in **PowerShell**](https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_environment_variables?view=powershell-7.1#using-and-changing-environment-variables).

Run seeding script in [`db/seeds.rb`](https://github.com/thuy-econsys/rails_app/blob/master/db/seeds.rb) to generate users to play with:
```ruby
rails db:seed
```

# Customize User Registration

Add *approved* column to Users model which defaults to false, pending Admin approval:
```bash
rails g migration AddApprovedToUsers approved:boolean
```

Adjust migration to include `:default => false`. Possibly consider adding `:null => false` later?
```ruby
class AddApprovedToUsers < ActiveRecord::Migration
  def change
    add_column :users, :approved, :boolean, :default => false
  end
end
```

Add *notes* column to Users model. Also add *notes* `<div>` to `app/views/devise/registrations/new.html.erb`:
```bash
rails g migration AddNotesToUsers notes:string
```

Migrate the databases:
```bash
rails db:migrate
```

Access Devise User Controller in order to override Devise::RegistrationsController: 
```bash
rails generate devise:controllers users
```

Change `devise_for :users` in the `config/routes.rb` file to:
```ruby
devise_for :users, path: "account", :controllers => { registrations: 'users/registrations' }
```

Note that _path_ is **account** to avoid any conflict with Administrative edits of User from Dashboard. 


# Mailer


`app/controllers/users/registrations_controller.rb`
```ruby
...

# POST /resource
  def create
      super
      AdminMailer.with(user: @user).admin_approval_email.deliver
  end

...
  protected

  def configure_sign_up_params
    devise_parameter_sanitizer.permit(:sign_up, keys: [:notes])
  end

  def configure_account_update_params
    devise_parameter_sanitizer.permit(:account_update, keys: [:notes])
  end
...
```

`app/mailers/application_mailer.rb`
```ruby
class ApplicationMailer < ActionMailer::Base
  default from: '$MG_USERNAME' 
  layout 'mailer'
end
```

Note that in the overridden `Users::RegistrationsController#create` method, the `AdminMailer` passes a key value pair `(user: @user)` to `with`. This creates a `params[:user]` for the mailer action `admin_approval_email` to use, similar to how controllers have access to params.

`app/mailers/admin_mailer.rb`
```ruby
class AdminMailer < ApplicationMailer 
  def admin_approval_email
    mail(
      to: params[:user].email,
      subject: 'Welcome to my Rails App')
  end
end
```

`admin_approval_email` returns an `ActionMailer::MessageDelivery` object which is a wrapper around a `Mail::Message` object. `ActionMailer::MessageDelivery` has a `message` method for inspecting or altering the `Mail::Message` object. 

`app/views/admin_mailer/admin_approval_email.html.erb`
```html
<h1><%= @user.email %> is awaiting admin approval</h1>

<p>An administrator can approve this registration by visiting the website and editing the user</p>
```

You will get an alert "translation missing: en.devise.failure.user.not_approved" if you don't add a proper alert to your `config/locales/devise.en.yml` file: 
```yml

en:
  devise:
...  
    failure:
...
      user:
        not_approved: "You have signed up successfully but your account has not been approved by your administrator yet."
```

[Rails Mailer Tutorial](https://medium.com/@ericschwartz7/rails-mailer-tutorial-82700f6737d9)