# Misty::Openstack::Analytics

This is the plugin Gem to consume the OpenStack Analytics API.

The main maintainer for the OpenStack analytics section are [hgw77](https://github.com/hgw77)).

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'misty-limes', git: 'https://github.com/sapcc/misty-analytics'
```

And then execute:

    $ bundle

### Initial Setup

Require the gem:

```ruby
require 'misty/openstack/analytics'
```

## Usage

```ruby
require 'misty/openstack/analytics'

auth_v3 = {
  :url              => "http://localhost:5000",
  :user             => "admin",
  :password         => "secret",
  :project_id       => "XXX",
  :domain_id        => "XXX",
  :user_domain_id   => "XXX"
}

cloud = Misty::Cloud.new(:auth => auth_v3,  :region_id => "staging", :log_level => 2)

# PROJECT SCOPE
cloud.masterdata.get_project("PROJECT_ID")

# DOMAIN SCOPE
cloud.resources.get_domain("DOMAIN_ID")

```

## Development

1. Within the directory run `rvm use ruby-2.3.1@misty-analytics`
2. RUN gem install bundler
3. Run `bundle install --with=development`
4. Run the tests
    1. rename dotenv to .env and run `bundle exec rake analytics`
    2. Note: if you need to rerun the tests without vcr tapes you need to set your env variables first, take a look to the dotenv file

Note: if you use mitmproxy set the http_proxy to the url where your proxy is running and unset "no_proxy" 

## License

The gem is available as open source under the terms of the enclosed Apache-2.0

