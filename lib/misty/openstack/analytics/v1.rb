require 'misty/http/client'
require "misty/openstack/analytics/analytics_v1"

module Misty
  module Openstack
    module Analytics
      class V1 < Misty::HTTP::Client
        extend Misty::Openstack::AnalyticsV1

        def self.api
          # https://billing.eu-de-1.cloud.sap:64000/masterdata/#
          v1
        end

        def self.service_names
          %w{sapcc-analytics}
        end
      end
    end
  end
end
