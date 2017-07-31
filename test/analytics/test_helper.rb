require 'misty'
require 'minitest/autorun'
require 'vcr'
require 'webmock/minitest'
require 'byebug'

VCR.configure do |config|
  config.cassette_library_dir = "test/integration/vcr"
  config.hook_into :webmock
end

def auth_project
  {
    :url            => ENV['OPENSTACK_AUTH_API_ENDPOINT'],
    :user           => ENV['TEST_PROJECT_ADMIN'],
    :password       => ENV['TEST_PROJECT_PASSWORD'],
    :project_id     => ENV['TEST_PROJECT_ID'],
    :domain_id      => ENV['TEST_DOMAIN_ID'],
    :user_domain_id => ENV['TEST_DOMAIN_ID'],
  }
end

def auth_domain
  {
    :url            => ENV['OPENSTACK_AUTH_API_ENDPOINT'],
    :user           => ENV['TEST_DOMAIN_ADMIN'],
    :password       => ENV['TEST_DOMAIN_ADMIN_PASSWORD'],
    :domain_id      => ENV['TEST_DOMAIN_ID'],
    :user_domain_id => ENV['TEST_DOMAIN_ID']
  }
end