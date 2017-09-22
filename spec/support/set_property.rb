# Set up a test property and stub out the domain.
RSpec.configure do |config|
  config.before :each, type: :request do
    @property = create(:property_with_api_client)

    domain = "#{@property.subdomain}.automatedhotel.com"
    host! domain
  end

  config.before :each, type: :mailer do
    @property = create(:property_with_api_client)
  end
end