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