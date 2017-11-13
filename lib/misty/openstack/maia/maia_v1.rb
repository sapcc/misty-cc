module Misty::Openstack::MaiaV1
  def v1
    {
      # https://prometheus.io/docs/prometheus/latest/querying/api/
      # Note: the query string is the last parameter and automatically added if existing
      "/query" => {:GET=>[:query]},
      "/query_range" => {:GET=>[:query_range]},
      "/series" => {:GET=>[:series]},
      "/label/{label_name}/values" => {:GET=>[:label_values]},
    }
  end
end
