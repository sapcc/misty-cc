require 'misty/client_pack'
require "misty/openstack/ccmasterdata/ccmasterdata_v2"

module Misty
  module Openstack
    module Ccmasterdata
      class V2
        include Misty::Openstack::CcmasterdataV2
        include Misty::ClientPack

        def service_names
          # this is used to find the correct endpoint (type) in the service catalog
          %w{sapcc-billing}
        end
      end
    end
  end
end
