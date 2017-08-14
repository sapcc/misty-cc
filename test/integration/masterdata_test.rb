require 'test_helper'
require 'misty/openstack/cc'

# http://docs.seattlerb.org/minitest/

describe "Masterdata Service CC-Masterdata features" do

  it "handle domain scope" do
    VCR.use_cassette "setting domain masterdata" do
      
      cloud = Misty::Cloud.new(
        :auth             => auth_domain,
        :region_id        => ENV["TEST_REGION_ID"],
        :log_level        => 2,
        :ssl_verify_mode  => false,
        )
      
      domain_master_data ={ 
        "description":"MyDomain is about providing important things",
        "responsible_controller_id": "D000000",
        "responsible_controller_email": "myDL@sap.com",
        "cost_object": {
            "type": "IO",
            "name": "110377",
            "projects_can_inherit": true
        }
      }
      
      response = cloud.masterdata.set_domain(ENV["TEST_DOMAIN_ID"], domain_master_data)
      response.code.must_equal "204"
    end

    VCR.use_cassette "getting domain masterdata" do
      
      cloud = Misty::Cloud.new(
        :auth             => auth_domain,
        :region_id        => ENV["TEST_REGION_ID"],
        :log_level        => 2,
        :ssl_verify_mode  => false,
        :masterdata       => { :api_version => "v2" }
        )
      
      response = cloud.masterdata.get_domain(ENV["TEST_DOMAIN_ID"])
      response.code.must_equal "200"
      assert_equal ENV["TEST_DOMAIN_ID"], response.body["domain_id"], "check for domain id"
      assert_equal ENV["TEST_DOMAIN_NAME"], response.body["domain_name"], "check for domain name"
      assert_equal "MyDomain is about providing important things", response.body["description"], "check for domain description"
      assert_equal 1, response.body["projects_can_inherit"], "check for domain projects_can_inherit"
      assert_equal "D000000", response.body["responsible_controller_id"], "check for domain responsible_controller_id"
      assert_equal "myDL@sap.com", response.body["responsible_controller_email"], "check for domain responsible_controller_email"
      assert_equal "110377", response.body["cost_object"]["name"], "check for domain cost_object name"
      assert_equal "IO", response.body["cost_object"]["type"], "check for domain cost_object type"

    end

    VCR.use_cassette "update domain masterdata" do
      
      cloud = Misty::Cloud.new(
        :auth             => auth_domain,
        :region_id        => ENV["TEST_REGION_ID"],
        :log_level        => 2,
        :ssl_verify_mode  => false,
        :masterdata       => { :api_version => "v2", :service_names => "sapcc-analytics" }
        )

      domain_master_data ={ 
        "description":"MyDomain is about providing very important things",
        "responsible_controller_id": "D123456",
        "responsible_controller_email": "myNewDL@sap.com",
        "cost_object": {
            "type": "IO",
            "name": "11031977",
            "projects_can_inherit": true,
        }
      }

      response = cloud.masterdata.set_domain(ENV["TEST_DOMAIN_ID"],domain_master_data)
      response.code.must_equal "204"

    end
    
    VCR.use_cassette "check updated domain masterdata" do
      
      cloud = Misty::Cloud.new(
        :auth             => auth_domain,
        :region_id        => ENV["TEST_REGION_ID"],
        :log_level        => 2,
        :ssl_verify_mode  => false,
        :masterdata       => { :api_version => "v2" }
        )
      
      response = cloud.masterdata.get_domain(ENV["TEST_DOMAIN_ID"])
      response.code.must_equal "200"
      assert_equal "MyDomain is about providing very important things", response.body["description"], "check for domain description"
      assert_equal 1, response.body["projects_can_inherit"], "check for domain projects_can_inherit"
      assert_equal "D123456", response.body["responsible_controller_id"], "check for domain responsible_controller_id"
      assert_equal "myNewDL@sap.com", response.body["responsible_controller_email"], "check for domain responsible_controller_email"
      assert_equal "11031977", response.body["cost_object"]["name"], "check for domain cost_object name"
      assert_equal "IO", response.body["cost_object"]["type"], "check for domain cost_object type"

    end

    VCR.use_cassette "analytics check inheritance for domain" do
      
      cloud = Misty::Cloud.new(
        :auth             => auth_domain,
        :region_id        => ENV["TEST_REGION_ID"],
        :log_level        => 2,
        :ssl_verify_mode  => false,
        :masterdata       => { :api_version => "v2" }
        )
      
      response = cloud.masterdata.inheritance('domain_id' => ENV["TEST_DOMAIN_ID"])
      response.code.must_equal "200"
      assert_equal true, response.body["co_inheritable"], "check inheritance"
      assert_equal "11031977", response.body["cost_object"]["name"], "check for domain cost_object name"
      assert_equal "IO", response.body["cost_object"]["type"], "check for domain cost_object type"
    
    end
    
  end

  it "handle project scope" do

    VCR.use_cassette "set blank project masterdata domain" do
      
      cloud = Misty::Cloud.new(
        :auth             => auth_project,
        :region_id        => ENV["TEST_REGION_ID"],
        :log_level        => 2,
        :ssl_verify_mode  => false,
        :masterdata       => { :api_version => "v2" }
        )

      project_master_data ={ 
        "revenue_relevance": "generating",
        "business_criticality":"prod",
        "cost_object": {
          "inherited": true
        }
      }

      response = cloud.masterdata.set_project(ENV["TEST_PROJECT_ID"],project_master_data)
      response.code.must_equal "204"

    end

    VCR.use_cassette "check inherited domain masterdata" do
      
      cloud = Misty::Cloud.new(
        :auth             => auth_project,
        :region_id        => ENV["TEST_REGION_ID"],
        :log_level        => 2,
        :ssl_verify_mode  => false,
        :masterdata       => { :api_version => "v2" }
        )

        response = cloud.masterdata.get_project(ENV["TEST_PROJECT_ID"])
        response.code.must_equal "200"
        assert_equal "11031977", response.body["cost_object"]["name"], "check for inherited domain cost_object name"
        assert_equal "IO", response.body["cost_object"]["type"], "check for inherited domain cost_object type"
        assert_equal true, response.body["cost_object"]["co_inherited"], "check for inherited flag"
        
    end

    VCR.use_cassette "setting own project and disabling inheritance for masterdata" do
      
      cloud = Misty::Cloud.new(
        :auth             => auth_project,
        :region_id        => ENV["TEST_REGION_ID"],
        :log_level        => 2,
        :ssl_verify_mode  => false,
        :masterdata       => { :api_version => "v2" }
        )
      
      project_master_data = {
        "description":"MyProject is about providing important things",
        "responsible_operator_id":"D000000",
        "responsible_operator_email":"DL1337@sap.com",
        "responsible_security_expert_id":"D000000",
        "responsible_security_expert_email": "myName@sap.com",
        "responsible_product_owner_id":"D000000",
        "responsible_product_owner_email": "myName@sap.com",
        "responsible_controller_id":"D000000",
        "responsible_controller_email": "myName@sap.com",
        "revenue_relevance": "generating",
        "business_criticality":"prod",
        "solution": "SAPCloud",
        "number_of_endusers":100,
         "cost_object": {
             "type": "CC",
             "name": "300494998"
          }
      }
      
      response = cloud.masterdata.set_project(ENV["TEST_PROJECT_ID"], project_master_data)
      response.code.must_equal "204"
    end

    VCR.use_cassette "check project masterdata" do
     cloud = Misty::Cloud.new(
        :auth             => auth_project,
        :region_id        => ENV["TEST_REGION_ID"],
        :log_level        => 2,
        :ssl_verify_mode  => false,
        :masterdata       => { :api_version => "v2" }
        )

        response = cloud.masterdata.get_project(ENV["TEST_PROJECT_ID"])
        response.code.must_equal "200"
        assert_equal ENV["TEST_PROJECT_ID"], response.body["project_id"], "check for project id"
        assert_equal ENV["TEST_DOMAIN_ID"], response.body["parent_id"], "check for parent id"
        assert_equal "300494998", response.body["cost_object"]["name"], "check for own project cost_object name"
        assert_equal "CC", response.body["cost_object"]["type"], "check for own project cost_object type"
        assert_equal false, response.body["cost_object"]["co_inherited"], "check for inheritence flag"
        assert_equal "D000000", response.body["responsible_operator_id"], "check for responsible_operator_id"
        assert_equal "DL1337@sap.com", response.body["responsible_operator_email"], "check for responsible_operator_email"
        assert_equal "D000000", response.body["responsible_security_expert_id"], "check for responsible_security_expert_id"
        assert_equal "myName@sap.com", response.body["responsible_security_expert_email"], "check for responsible_security_expert_email"
        assert_equal "D000000", response.body["responsible_product_owner_id"], "check for responsible_product_owner_id"
        assert_equal "myName@sap.com", response.body["responsible_product_owner_email"], "check for esponsible_product_owner_email"
        assert_equal "D000000", response.body["responsible_controller_id"], "check for responsible_controller_id"
        assert_equal "myName@sap.com", response.body["responsible_controller_email"], "check for responsible_controller_email"
        assert_equal "generating", response.body["revenue_relevance"], "check for revenue_relevance"
        assert_equal "prod", response.body["business_criticality"], "check for business_criticality"
        assert_equal "SAPCloud", response.body["solution"], "check for solution"
        assert_equal 100, response.body["number_of_endusers"], "check for number_of_endusers"

    end

    VCR.use_cassette "update project masterdata" do
      
      cloud = Misty::Cloud.new(
        :auth             => auth_project,
        :region_id        => ENV["TEST_REGION_ID"],
        :log_level        => 2,
        :ssl_verify_mode  => false,
        :masterdata       => { :api_version => "v2" }
        )
      
      project_master_data = {
        "description":"MyProject is about providing new important things",
        "responsible_operator_id":"D123456",
        "responsible_operator_email":"DLBLA@sap.com",
        "responsible_security_expert_id":"D123456",
        "responsible_security_expert_email": "myNewName@sap.com",
        "responsible_product_owner_id":"D123456",
        "responsible_product_owner_email": "myNewName@sap.com",
        "responsible_controller_id":"D123456",
        "responsible_controller_email": "myNewName@sap.com",
        "business_criticality":"staging",
        "revenue_relevance": "generating",
        "solution": "CCloud",
        "number_of_endusers":10000,
         "cost_object": {
             "type": "IO",
             "name": "132123123213"
          }
      }
      
      response = cloud.masterdata.set_project(ENV["TEST_PROJECT_ID"], project_master_data)
      response.code.must_equal "204"
    end

    VCR.use_cassette "check updated project masterdata" do
     cloud = Misty::Cloud.new(
        :auth             => auth_project,
        :region_id        => ENV["TEST_REGION_ID"],
        :log_level        => 2,
        :ssl_verify_mode  => false,
        :masterdata       => { :api_version => "v2" }
        )

        response = cloud.masterdata.get_project(ENV["TEST_PROJECT_ID"])
        response.code.must_equal "200"
        assert_equal "132123123213", response.body["cost_object"]["name"], "check for updated project cost_object name"
        assert_equal "IO", response.body["cost_object"]["type"], "check for updated project cost_object type"
        assert_equal "D123456", response.body["responsible_operator_id"], "check for updated responsible_operator_id"
        assert_equal "DLBLA@sap.com", response.body["responsible_operator_email"], "check for updated responsible_operator_email"
        assert_equal "D123456", response.body["responsible_security_expert_id"], "check for updated responsible_security_expert_id"
        assert_equal "myNewName@sap.com", response.body["responsible_security_expert_email"], "check for updated responsible_security_expert_email"
        assert_equal "D123456", response.body["responsible_product_owner_id"], "check for updated responsible_product_owner_id"
        assert_equal "myNewName@sap.com", response.body["responsible_product_owner_email"], "check for updated esponsible_product_owner_email"
        assert_equal "D123456", response.body["responsible_controller_id"], "check for updated responsible_controller_id"
        assert_equal "myNewName@sap.com", response.body["responsible_controller_email"], "check for updated responsible_controller_email"
        assert_equal "staging", response.body["business_criticality"], "check for updated business_criticality"
        assert_equal "CCloud", response.body["solution"], "check for updated solution"
        assert_equal 10000, response.body["number_of_endusers"], "check updated for number_of_endusers"

    end

    VCR.use_cassette "enable inheritance for project masterdata" do
      
      cloud = Misty::Cloud.new(
        :auth             => auth_project,
        :region_id        => ENV["TEST_REGION_ID"],
        :log_level        => 2,
        :ssl_verify_mode  => false,
        :masterdata       => { :api_version => "v2" }
        )

      project_master_data ={ 
        "revenue_relevance": "generating",
        "business_criticality":"prod",
        "cost_object": {
          "inherited": true
        }
      }

      response = cloud.masterdata.set_project(ENV["TEST_PROJECT_ID"],project_master_data)
      response.code.must_equal "204"

    end

    VCR.use_cassette "check inherited domain masterdata again" do
      
     cloud = Misty::Cloud.new(
        :auth             => auth_project,
        :region_id        => ENV["TEST_REGION_ID"],
        :log_level        => 2,
        :ssl_verify_mode  => false,
        :masterdata       => { :api_version => "v2" }
        )

        response = cloud.masterdata.get_project(ENV["TEST_PROJECT_ID"])
        response.code.must_equal "200"
        assert_equal "11031977", response.body["cost_object"]["name"], "check for inherited domain cost_object name"
        assert_equal "IO", response.body["cost_object"]["type"], "check for inherited domain cost_object type"
        assert_equal true, response.body["cost_object"]["co_inherited"], "check for inherited flag"
        
    end

  end

end