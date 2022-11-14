source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.1.2'

# Bundle edge Rails instead: gem "rails", github: "rails/rails", branch: "main"
gem 'rails', '~> 7.0.4'

# Use postgresql as the database for Active Record
gem 'pg', '~> 1.1'

# Use the Puma web server [https://github.com/puma/puma]
gem 'puma', '~> 5.0'

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', require: false

# Rails background jobs
gem 'sidekiq', '~> 7.0'

# Authorization and authentication
gem 'devise', '~> 4.8'
gem 'devise_invitable'
gem 'devise-jwt'
gem 'pundit', '~> 2.2'

# Pagination
gem 'kaminari', '~> 1.2'

# Caching
gem 'redis', '~> 5.0'

# Image uploading
gem 'carrierwave', '~> 2.2'

# Soft deletion of db records
gem 'discard', '~> 1.2'

# State management
gem 'aasm', '~> 5.4'

# Environment settings
gem 'dotenv-rails', require: 'dotenv/rails-now'

group :development, :test do
  # See https://guides.rubyonrails.org/debugging_rails_applications.html#debugging-with-the-debug-gem
  gem 'debug', platforms: %i[mri mingw x64_mingw]
end

group :development do
  # Speed up commands on slow machines / big apps [https://github.com/rails/spring]
  gem 'spring'
end

group :test do
  gem 'capybara', '~> 3.38'
  gem 'rspec-rails', '~> 6.0.0'
end
