require_relative 'boot'

VERSION = '0.3.3'

require "rails"
# Pick the frameworks you want:
require "active_model/railtie"
require "active_job/railtie"
require "active_record/railtie"
require "action_controller/railtie"
require "action_mailer/railtie"
require "action_view/railtie"
require "action_cable/engine"
require "sprockets/railtie"
# require "rails/test_unit/railtie"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

# From https://gist.github.com/t2/1464315
ActionView::Base.field_error_proc = Proc.new do |html_tag, instance|
  html = %(<div class="field_with_errors">#{html_tag}</div>).html_safe
  # add nokogiri gem to Gemfile
  elements = Nokogiri::HTML::DocumentFragment.parse(html_tag).css "label, input"
  elements.each do |e|
    if e.node_name.eql? 'label'
      html = %(<div class="clearfix has-error">#{e}</div>).html_safe
    elsif e.node_name.eql? 'input'
      if instance.error_message.kind_of?(Array)
        html = %(<div class="clearfix has-error">#{html_tag}<span class="help-inline">&nbsp;#{instance.error_message.join(',')}</span></div>).html_safe
      else
        html = %(<div class="clearfix has-error">#{html_tag}<span class="help-inline">&nbsp;#{instance.error_message}</span></div>).html_safe
      end
    end
  end
  html
end

module GuestApiApp
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.1

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Don't generate system test files.
    config.generators.system_tests = nil
  end
end
