# Misty::Openstack::CC

This Gem extends [misty](https://github.com/flystack/misty/) with SAPs ConvergedCloud Openstack Services.

Currently supported services are

* [limes/resources](https://github.com/sapcc/limes)
* analytics/masterdata

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'misty-cc', git: 'https://github.com/sapcc/misty-cc'
```

And then execute:

    $ bundle install

### Initial Setup

Require the gem:

```ruby
require 'misty/openstack/cc'
```

## Usage

```ruby
require 'misty/openstack/cc'

auth_v3 = {
  :url              => "http://localhost:5000",
  :user             => "admin",
  :password         => "secret",
  :project_id       => "XXX",
  :domain_id        => "XXX",
  :user_domain_id   => "XXX"
}


# Analytics/Masterdata
cloud = Misty::Cloud.new(
            :auth => auth_v3,
            :region_id => "staging",
            :log_level => 2,
        )

# PROJECT SCOPE
cloud.masterdata.get_project(PROJECT_ID)

project_master_data ={ 
"revenue_relevance": "generating",
"business_criticality":"prod",
"cost_object": {
  "inherited": true
}
cloud.masterdata.set_project(PROJECT_ID,project_master_data)

# DOMAIN SCOPE
cloud.masterdata.get_domain(DOMAIN_ID)

# Limes/Resources
cloud = Misty::Cloud.new(
            :auth => auth_v3,
            :region_id => "staging",
            :log_level => 2
        )

# PROJECT SCOPE
cloud.resources.get_project(DOMAIN_ID,PROJECT_ID)
cloud.resources.get_service_for_project(DOMAIN_ID,PROJECT_ID,"compute")
cloud.resources.get_service_resource_for_project(DOMAIN_ID,PROJECT_ID,"compute","cores")
cloud.resources.sync_project(DOMAIN_ID,PROJECT_ID)

# DOMAIN SCOPE
cloud.resources.discover_domain_projects(DOMAIN_ID)

cloud.resources.get_domain(DOMAIN_ID)
cloud.resources.get_service_for_domain(DOMAIN_ID,"compute")
cloud.resources.get_service_resource_for_domain(DOMAIN_ID,"compute","cores")

new_quota = {
            "services": [
              {
                "type": "compute",
                "resources": [
                  {
                    "name": "instances",
                    "quota": 10
                  },
                  {
                    "name": "cores",
                    "quota": 10
                  }
                ]
              }
            ]
          }

cloud.resources.set_quota_for_domain(DOMAIN_ID, "domain" => new_quota)

# 

```

## Development

1. Within the directory run `rvm use ruby-2.3.1@misty-cc`
2. RUN gem install bundler
3. Run `bundle install --with=development`
4. rename dotenv to .env
5. run `bundle exec rake all`

### Note: 
* if you need to rerun the tests without vcr tapes you need to set your env variables first, take a look to the dotenv file
* if you use mitmproxy set the http_proxy to the url where your proxy is running and unset "no_proxy" 

## License

The gem is available as open source under the terms of the enclosed Apache-2.0

