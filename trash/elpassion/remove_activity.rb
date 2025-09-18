#!/usr/bin/env ruby
# frozen_string_literal: true
require 'date'
require 'json'
require 'net/http'

def api_token
  ENV['ELPASSION_API_TOKEN']
end

start_day = ARGV[0]
end_day = ARGV[1]

unless api_token 
  puts 'please set ELPASSION_API_TOKEN'

  exit 1
end

unless start_day && end_day 
  puts 'please provide start date and end date'

  exit 1
end

def delete_activity(id:)
  return unless id[0]
  url = "https://hub.elpassion.com/api/v2/reports/#{id[0]}"
  uri = URI(url)

  req = Net::HTTP::Delete.new(uri.request_uri)

  req['X_ACCESS_TOKEN'] = api_token


  req = Net::HTTP.start(uri.hostname, uri.port, use_ssl: true) do |http|
    http.request(req)
  end

  puts req
end


def fetch_reprts_for_given_month(date)
  uri = URI('https://hub.elpassion.com/api/v2/calendar')
  params = { date:  date }
  uri.query = URI.encode_www_form(params)

  req = Net::HTTP::Get.new(uri.request_uri)

  req['X_ACCESS_TOKEN'] = api_token

  req = Net::HTTP.start(uri.hostname, uri.port, use_ssl: true) do |http|
    http.request(req)
  end

  JSON.parse(req.body)
end

def get_reports_for_date(reports:, date:)
  reports.find { |data_set| data_set['date'] == date.to_s }['reports']
end


start_date = Date.parse([start_day, Date.today.month.to_s, Date.today.year.to_s].join('-'))
end_date = Date.parse([end_day, Date.today.month.to_s, Date.today.year.to_s].join('-'))
date_range = (start_date..end_date).to_a

reports = fetch_reprts_for_given_month(Date.today)

reports_ids_for_removal = []
date_range.each do |date|
  reports_ids = get_reports_for_date(reports: reports, date: date).map { |e| e['id'] }
  reports_ids_for_removal.push(reports_ids)
end

reports_ids_for_removal.flatten 

# for some reason the each object it's an array itself
reports_ids_for_removal.each { |id| delete_activity(id: id) }


