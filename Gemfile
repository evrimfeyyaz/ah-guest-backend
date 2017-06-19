source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end


gem 'rails', '~> 5.1.0'
gem 'pg', '~> 0.18'
gem 'puma', '~> 3.7'
gem 'active_model_serializers', '~> 0.10.6'
gem 'paperclip', '~> 5.1'
gem 'rubocop', '~> 0.48.1'
gem 'sass-rails', '~> 5.0'
gem 'jquery-rails', '~> 4.3'
gem 'bootstrap-sass', '~> 3.3', '>= 3.3.7'
gem 'bootstrap-datepicker-rails'
gem 'bootstrap_form'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.2'
gem 'turbolinks', '~> 5'
gem 'bcrypt', '~> 3.1', '>= 3.1.11'
gem 'nokogiri', '~> 1.8'
gem 'devise', '~> 4.3'
gem 'mailgun-ruby', '~>1.1.6'

group :production do
  gem 'aws-sdk', '~> 2.9', '>= 2.9.15'
end

group :development, :test do
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  gem 'rspec-rails', '~> 3.6'
  gem 'factory_girl_rails', '~> 4.8'
  gem 'shoulda-matchers', git: 'https://github.com/thoughtbot/shoulda-matchers.git', branch: 'rails-5'
  gem 'capybara', '~> 2.13'
  gem 'capybara-webkit', '~> 1.14'
end

group :development do
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]

ruby '2.4.1'