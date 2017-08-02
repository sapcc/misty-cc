require 'misty'

# this will extend misty with sap converged cloud related services
module Misty

  @services_plus_limes = self.services
  
  # resource and quota management
  @services_plus_limes.add(:resources, :limes, ["v1"])
  # masterdata, billing and analytics
  @services_plus_limes.add(:"sapcc-analytics", :analytics, ["v2"])

  def self.services
    @services_plus_limes
  end

  class Cloud
    def resources
      @resources ||= build_service(:resources)
    end
    
    def masterdata
      @masterdata ||= build_service(:"sapcc-analytics")
    end  
  end

  module Openstack
    module Limes
      autoload :V1, "misty/openstack/limes/v1"
    end

    module Analytics
      autoload :V2, "misty/openstack/analytics/v2"
    end
  end
end
