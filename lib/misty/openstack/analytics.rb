require 'misty'

module Misty

  @services_plus_limes = self.services
  @services_plus_limes.add(:"sapcc-analytic", :analytics, ["v1"])

  def self.services
    @services_plus_limes
  end

  class Cloud
    def masterdata
      @masterdata ||= build_service(:"sapcc-analytic")
    end
  end

  module Openstack
    module Analytics
      autoload :V1, "misty/openstack/analytics/v1"
    end
  end
  
end
