#!/usr/bin/env ruby
# frozen_string_literal: true

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


def begging_of_month 
  Date.parse(['1', Date.today.month.to_s, Date.today.year.to_s].join('-'))
end

def end_of_month
  begging_of_month.next_month.prev_day
end

def upesert_activity_for_date(date)
  uri = URI('https://hub.elpassion.com/api/v2/reports')

  req = Net::HTTP::Post.new(uri.request_uri)

  req['X_ACCESS_TOKEN'] = api_token

  req.set_form_data(activity_id: 'f4d9c08b-0639-43ca-93b3-009dac7fae8f', # does not matter in the current api
                    performed_on: date,
                    project_id: 299, # other
                    reported_hours: 0.5,
                    description: 'lunch')


  req = Net::HTTP.start(uri.hostname, uri.port, use_ssl: true) do |http|
    http.request(req)
  end

  puts req
end


(begging_of_month..end_of_month).reject { |date| date.saturday? || date.sunday? }.each { |date| upesert_activity_for_date(date) }


