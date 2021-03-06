module Misty::Openstack::CcmasterdataV2
  def api
    {
      "/masterdata/projects/{project_id}" => {:GET=>[:get_project], :PUT=>[:set_project]},
      "/masterdata/domains/{domain_id}" => {:GET=>[:get_domain], :PUT=>[:set_domain]},
      "/masterdata/inheritance/"  => {:GET=>[:inheritance]},
      "/masterdata/missing/"  => {:GET=>[:get_missing_projects]},
      "/masterdata/solutions/" => {:GET=>[:get_solutions]}
    }
  end
end
