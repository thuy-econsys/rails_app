# Devise

```bash
rails generate devise:install
rails generate devise User
rails db:migrate
rails generate devise:views:bootstrap_templates
```

Normally the views generator is `rails generate devise:views` but there's a gem that automates Bootstrap styling to Devise templates, `devise-bootstrap-views`, so the rails generator is `rails generate devise:views:bootstrap_templates`.

# Styling

Gemfiles added for Bootstrap styling: 

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

```bash
psql -h $PG_HOST -U $PG_USERNAME -p $PG_PORT $PG_DBNAME
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
devise_for :users, :controllers => { registrations: 'registrations' }
```