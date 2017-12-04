require 'misty/client_pack'
require "misty/openstack/limes/limes_v1"

module Misty
  module Openstack
    module Limes
      class V1
        include Misty::Openstack::LimesV1
        include Misty::ClientPack

        def service_names
          %w{resources}
        end
      end
    end
  end
end
