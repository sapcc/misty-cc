module Misty::Openstack::AnalyticsV1
  def v1
    {
      "/masterdata/projects/{project_id}" => {:GET=>[:get_project], :PUT=>[:set_project]},
      "/masterdata/domains/{domain_id}" => {:GET=>[:get_domain], :PUT=>[:set_domain]},
    }
  end
end
