require 'misty/client_pack'
require "misty/openstack/maia/maia_v1"

module Misty
  module Openstack
    module Maia
      class V1
        include Misty::Openstack::MaiaV1
        include Misty::ClientPack

        def service_names
          %w{metrics}
        end
      end
    end
  end
end
