source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.5.1'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 5.2.4', '>= 5.2.4.1'
# Use postgresql as the database for Active Record
gem 'pg', '>= 0.18', '< 2.0'
# Use Puma as the app server
gem 'puma', '~> 3.11'
# Use the C implementation of SCSS for stylesheets due to deprecation of sass-rails
gem 'sassc-rails'

gem 'bootstrap'
# Bootstrap Javascript depends on jQuery
gem 'jquery-rails'
# Bootstrap dropdowns rely on JavaScript and Turbolinks
gem 'jquery-turbolinks'
# Devise Views customizations
gem 'devise-bootstrap-views', '~> 1.0'

# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.2'
# Turbolinks makes navigating your web application faster. Read more: https://github.com/turbolinks/turbolinks
gem 'turbolinks', '~> 5'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.5'

# Authentication
gem 'devise'
# Support for internationalized views
gem 'devise-i18n'
# 3rd-party credentials authentication, possibly not necessary but just in case...
gem 'omniauth'
# for OmniAuth 2.0+ https://github.com/cookpad/omniauth-rails_csrf_protection
# gem 'omniauth-rails_csrf_protection'

gem 'omniauth-google-oauth2'
# OmniAuth 1.0 compatible port of the previously available OmniAuth CAS strategy
# gem 'omniauth-cas'

# Authorization
# gem 'cancancan'

# Use ActiveStorage variant
# gem 'mini_magick', '~> 4.8'

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', '>= 1.1.0', require: false

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  gem 'rspec-rails', '~> 4.0.1'
  gem 'factory_bot_rails'
  gem 'faker'
  # Use deprecated rspec methods, assigns and assert_template
  gem 'rails-controller-testing'
end

group :development do
  # Access an interactive console on exception pages or by calling 'console' anywhere in the code.
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '>= 3.0.5', '< 3.2'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  # binstub for RSpec test runner for faster boot times via Spring
  gem 'spring-commands-rspec'
  # Preview email in browser instead of sending it
  gem 'letter_opener'
end

group :test do
  gem 'capybara'
  # one-liners to test common Rails functionality
  gem 'shoulda-matchers', '~> 4.0'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
