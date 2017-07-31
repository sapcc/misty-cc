require 'misty/http/client'
require "misty/openstack/analytics/analytics_v2"

module Misty
  module Openstack
    module Analytics
      class V2 < Misty::HTTP::Client
        extend Misty::Openstack::AnalyticsV2

        def self.api
          v2
        end

        def self.service_names
          %w{sapcc-analytics}
        end
      end
    end
  end
end
