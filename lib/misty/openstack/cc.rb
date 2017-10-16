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
  end

  module Openstack
    module Limes
      autoload :V1, "misty/openstack/limes/v1"
    end

    module Ccmasterdata
      autoload :V2, "misty/openstack/ccmasterdata/v2"
    end
  end
end
