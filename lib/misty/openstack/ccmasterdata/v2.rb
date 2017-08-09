require 'misty/http/client'
require "misty/openstack/ccmasterdata/ccmasterdata_v2"

module Misty
  module Openstack
    module Ccmasterdata
      class V2 < Misty::HTTP::Client
        extend Misty::Openstack::CcmasterdataV2

        def self.api
          v2
        end

        def self.service_names
          # this is used to find the correct endpoint (type) in the service catalog
          %w{sapcc-analytics}
        end
      end
    end
  end
end
