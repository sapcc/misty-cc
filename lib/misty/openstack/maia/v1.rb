require 'misty/http/client'
require "misty/openstack/maia/maia_v1"

module Misty
  module Openstack
    module Maia
      class V1 < Misty::HTTP::Client
        extend Misty::Openstack::MaiaV1

        def self.api
          # https://documentation.global.cloud.sap/docs/metrics/developers-guide.html
          v1
        end

        def self.service_names
          %w{metrics}
        end
      end
    end
  end
end
