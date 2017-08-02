require 'misty'

module Misty

  @services_plus_limes = self.services
  @services_plus_limes.add(:"sapcc-analytics", :analytics, ["v2"])

  def self.services
    @services_plus_limes
  end

  class Cloud
    def masterdata
      @masterdata ||= build_service(:"sapcc-analytics")
    end
  end

  module Openstack
    module Analytics
      autoload :V2, "misty/openstack/analytics/v2"
    end
  end
  
end
