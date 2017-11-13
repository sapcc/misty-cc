require 'misty'

# this will extend misty with sap converged cloud related services
module Misty

  @services_plus_limes = self.services
  
  # name    = openstack_type
  # project = openstack_name
  # @services_plus_limes.add(:name, :project, ["version"])
  
  # resource and quota management
  @services_plus_limes.add({name: :resources, project: :limes, versions: ["v1"]})
  # masterdata
  @services_plus_limes.add({name: :masterdata, project: :ccmasterdata, versions: ["v2"]})
  # maia metrics
  @services_plus_limes.add({name: :metrics, project: :maia, versions: ["v1"]})

  def self.services
    @services_plus_limes
  end

  class Cloud
    def resources
      @resources ||= build_service(:resources)
    end
    
    def masterdata
      @masterdata ||= build_service(:masterdata)
    end  
    
    def metrics
      @metrics ||= build_service(:metrics)
    end
  end

  module Openstack
    module Limes
      autoload :V1, "misty/openstack/limes/v1"
    end

    module Ccmasterdata
      autoload :V2, "misty/openstack/ccmasterdata/v2"
    end
    
    module Maia
      autoload :V1, "misty/openstack/maia/v1"
    end
  end
end
