source 'https://rubygems.org'
source 'https://rails-assets.org'

ruby "1.9.3"

gem 'rails', '4.0.1'
gem 'pg', '0.14.1'
gem 'unicorn-rails'
gem 'foreman'

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem "therubyracer", "~> 0.12.0"
  gem 'uglifier', '>= 1.0.3'
end

gem 'ember-rails', '~> 0.14.1'
gem 'ember-source', '~> 1.5.1'
gem 'ember-data-source', '~> 1.0.0.beta.7'

gem 'coffee-rails', '~> 4.0.1'
gem 'jquery-rails', '~> 3.0.4'
gem 'jquery-fileupload-rails', '~> 0.4.1'

gem 'sass-rails',   '~> 4.0.1'
gem 'bootstrap-sass', '~> 3.1.1.0'
gem 'font-awesome-sass', '~> 4.0.3.1'

gem 'paperclip', '~> 3.2'
gem 'aws-sdk'

group :development, :test do
  gem 'jasmine', '~>2.0.0'
  gem 'rspec-rails', '~> 2.14.2'
  gem 'factory_girl_rails', '~> 4.4.1'
  gem 'timecop', '~> 0.7.1'
  gem 'teaspoon', '~> 0.8.0'

  gem 'rails-assets-ember-qunit', '~>0.1.8'
  gem 'rails-assets-pretender'
end

#### Bower assets
# To include a bower library, use the form:
# gem 'rails-assets-BOWER_LIBRARY_NAME'

gem 'rails-assets-localforage', '~>0.8.1'
gem 'rails-assets-moment', '~>2.4.0'
gem 'rails-assets-jquery.cookie', '~>1.4.1'