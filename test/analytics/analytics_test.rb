require 'test_helper'
require 'misty/openstack/analytics'

# http://docs.seattlerb.org/minitest/

describe "analytics-masterdata features" do

  it "GET requests project" do
    VCR.use_cassette "requesting project masterdata" do
      
      cloud = Misty::Cloud.new(
        :auth             => auth_domain,
        :region_id        => ENV["TEST_REGION_ID"],
        :log_level        => 2,
        :ssl_verify_mode  => false
        )
      
      response = cloud.masterdata.get_domain(ENV["TEST_DOMAIN_ID"])
      puts response
    end
  end

end