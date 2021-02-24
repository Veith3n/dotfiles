#!/usr/bin/env ruby
# frozen_string_literal: true

# pass first argument with strings 

require 'date'
require 'json'
require 'net/http'

def api_token
  ENV['ELPASSION_API_TOKEN']
end

unless api_token 
  puts 'please set ELPASSION_API_TOKEN'

  exit 1
end


uri = URI('https://hub.elpassion.com/api/v2/reports')

req = Net::HTTP::Post.new(uri.request_uri)

req['X_ACCESS_TOKEN'] = api_token

req.set_form_data(activity_id: 'f4d9c08b-0639-43ca-93b3-009dac7fae8f', # does not matter in the current api
                  performed_on: Date.today,
                  project_id: PROVIDE_ID, 
                  reported_hours: ARGV[1] || 8,
                  description: ARGV[0])


req = Net::HTTP.start(uri.hostname, uri.port, use_ssl: true) do |http|
  http.request(req)
end

puts req
