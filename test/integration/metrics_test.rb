require 'test_helper'
require 'misty/openstack/cc'

# http://docs.seattlerb.org/minitest/

describe "test maia" do

  it "test" do

    VCR.use_cassette "getting domain masterdata" do
      
      cloud = Misty::Cloud.new(
        :auth             => auth_project,
        :region_id        => ENV["TEST_REGION_ID"],
        :log_level        => 2,
        :ssl_verify_mode  => false
      )
      
      #response = cloud.masterdata.get_domain(ENV["TEST_DOMAIN_ID"])
      #response.code.must_equal "200"
      #assert_equal ENV["TEST_DOMAIN_ID"], response.body["domain_id"], "check for domain id"
      #assert_equal ENV["TEST_DOMAIN_NAME"], response.body["domain_name"], "check for domain name"
      #assert_equal "MyDomain is about providing important things", response.body["description"], "check for domain description"
      #assert_equal 1, response.body["projects_can_inherit"], "check for domain projects_can_inherit"
      #assert_equal "D000000", response.body["responsible_controller_id"], "check for domain responsible_controller_id"
      #assert_equal "myDL@sap.com", response.body["responsible_controller_email"], "check for domain responsible_controller_email"
      #assert_equal "110377", response.body["cost_object"]["name"], "check for domain cost_object name"
      #assert_equal "IO", response.body["cost_object"]["type"], "check for domain cost_object type"

    end

 

  end

end