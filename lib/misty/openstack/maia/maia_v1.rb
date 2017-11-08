module Misty::Openstack::MaiaV1
  def v1
    {
      # https://prometheus.io/docs/prometheus/latest/querying/api/
      # Note: the query string is the last parameter and automatically added if existing
      "/api/v1/query" => {:GET=>[:query]},
      "/api/v1/query_range" => {:GET=>[:query_range]},
      "/api/v1/series" => {:GET=>[:series]},
      "/api/v1/label/{label_name}/values" => {:GET=>[:label_values]},
      "/api/v1/targets" => {:GET=>[:targets]},
      "/api/v1/alert_managers" => {:GET=>[:alertmanagers]}
    }
  end
end
