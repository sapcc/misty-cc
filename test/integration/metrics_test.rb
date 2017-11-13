require 'test_helper'
require 'misty/openstack/cc'

# http://docs.seattlerb.org/minitest/
# https://documentation.global.cloud.sap/docs/metrics/metrics.html
describe "test maia api" do

  it "get_values" do

    VCR.use_cassette "query_range_test" do
      
      cloud = Misty::Cloud.new(
        :auth             => auth_project,
        :region_id        => ENV["TEST_REGION_ID"],
        :log_level        => 2,
        :ssl_verify_mode  => false,
        :metrics => { 
          interface: 'public',
          headers: {'Content-Type' => 'application/json', 'Accept' => 'application/json'}
        }
      )
      
      vmware_name = ENV["VMWARE_NAME"]
      start_time  = Time.now - 60*60
      end_time    = Time.now
      
      response = cloud.metrics.query_range({
        'query' => "vcenter_cpu_usage_average{vmware_name='#{vmware_name}'}",
        'start' => start_time.to_i,
        'end'   => end_time.to_i,
        'step'  => "20"
        }
      )
      response.code.must_equal "200"
      assert_equal vmware_name, response.body["data"]["result"][0]["metric"]["vmware_name"], "check metrics"
      assert_kind_of String, response.body["data"]["result"][0]["values"][0][1], "check values"
      
    end

    VCR.use_cassette "query_test" do
      
      cloud = Misty::Cloud.new(
        :auth             => auth_project,
        :region_id        => ENV["TEST_REGION_ID"],
        :log_level        => 2,
        :ssl_verify_mode  => false,
        :metrics => { 
          interface: 'public',
          headers: {'Content-Type' => 'application/json', 'Accept' => 'application/json'}
        }
      )
      
      vmware_name = ENV["VMWARE_NAME"]
      response = cloud.metrics.query({
        'query' => "vcenter_cpu_usage_average{vmware_name='#{vmware_name}'}"}
      )
      response.code.must_equal "200"
      assert_equal vmware_name, response.body["data"]["result"][0]["metric"]["vmware_name"], "check metrics"
      assert_kind_of String, response.body["data"]["result"][0]["value"][1], "check current value"
      assert_equal "vector", response.body["data"]["resultType"], "check result type"
      
      # test query function
      response = cloud.metrics.query({
        'query' => "rate(vcenter_cpu_usage_average{vmware_name='#{vmware_name}'}[60m])"}
      )
      assert_equal vmware_name, response.body["data"]["result"][0]["metric"]["vmware_name"], "check metrics"
      assert_kind_of String, response.body["data"]["result"][0]["value"][1], "check current value"
      assert_equal "vector", response.body["data"]["resultType"], "check result type"
      
    end

    VCR.use_cassette "series_test" do
      
      cloud = Misty::Cloud.new(
        :auth             => auth_project,
        :region_id        => ENV["TEST_REGION_ID"],
        :log_level        => 2,
        :ssl_verify_mode  => false,
        :metrics => { 
          interface: 'public',
          headers: {'Content-Type' => 'application/json', 'Accept' => 'application/json'}
        }
      )
      
      vmware_name = ENV["VMWARE_NAME"]
      start_time  = Time.now - 60*60
      end_time    = Time.now
      response = cloud.metrics.series({
        'match[]' => "vcenter_cpu_usage_average{vmware_name='#{vmware_name}'}",
        'start' => start_time.to_i,
        'end'   => end_time.to_i
      }
      )
      response.code.must_equal "200"
      assert_equal vmware_name, response.body["data"][0]["vmware_name"], "check metrics"

    end
    
    VCR.use_cassette "label_values_test" do
      
      cloud = Misty::Cloud.new(
        :auth             => auth_project,
        :region_id        => ENV["TEST_REGION_ID"],
        :log_level        => 2,
        :ssl_verify_mode  => false,
        :metrics => { 
          interface: 'public',
          headers: {'Content-Type' => 'application/json', 'Accept' => 'application/json'}
        }
      )
      
      response = cloud.metrics.label_values("vmware_name")
      response.code.must_equal "200"
      assert_kind_of Array, response.body["data"], "check values"

    end


  end

end