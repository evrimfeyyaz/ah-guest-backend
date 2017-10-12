# Set up a test property and stub out the domain.
RSpec.configure do |config|
  %i{request feature mailer}.each do |type|
    config.before :each, type: type do
      @property = create(:property_with_api_client)
    end
  end

  config.before :each, type: :request do
    domain = "#{@property.subdomain}.lvh.me"
    host! domain
  end

  config.before :each, type: :feature do
    Capybara.app_host = "http://#{@property.subdomain}.lvh.me:49152"
    default_url_options[:host] = "#{@property.subdomain}.lvh.me:49152"
  end
end