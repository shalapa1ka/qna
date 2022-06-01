source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.0.0'
gem 'bootsnap', require: false
gem 'cssbundling-rails', '~> 1.1'
gem 'devise'
gem 'jbuilder'
gem 'jsbundling-rails', '~> 1.0'
gem 'pagy'
gem 'pg', '~> 1.1'
gem 'puma', '~> 5.0'
gem 'pundit', '~> 2.2'
gem 'rails', '~> 7.0.3'
gem 'sassc-rails'
gem 'sass-rails'
gem 'slim'
gem 'sprockets-rails'
gem 'stimulus-rails'
gem 'turbo-rails'
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]

group :development, :test do
  gem 'debug', platforms: %i[mri mingw x64_mingw]
  gem 'factory_bot_rails'
  gem 'faker'
  gem 'rails-controller-testing'
  gem 'rspec-rails'
  gem 'rubocop'
end

group :development do
  gem 'letter_opener'
  gem 'web-console'
end

group :test do
  gem 'capybara'
  gem 'selenium-webdriver'
  gem 'shoulda-matchers'
  gem 'webdrivers'
end

# Use Redis for Action Cable
gem "redis", "~> 4.0"
