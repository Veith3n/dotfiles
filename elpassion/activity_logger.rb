#!/usr/bin/env ruby

# pass first argument as string

require 'date'
require 'json'
require 'net/http'

def api_token
  ENV['ELPASSION_API_TOKEN']
end

activity_description = ARGV[0]
# custom_activity_time = ARGV[1]
custom_activity_time = nil
passed_date = ARGV[1] ? Date.strptime(ARGV[1], '%d/%m/%y') : nil # dd/mm/yy

unless api_token
  puts 'please set ELPASSION_API_TOKEN'

  exit 1
end

unless activity_description
  puts 'please provide string arg for acttivity description'

  exit 1
end

def upsert_activity_for_date(date, project_id:, reported_hours:, description:)
  uri = URI('https://hub.elpassion.com/api/v2/reports')

  req = Net::HTTP::Post.new(uri.request_uri)

  req['X_ACCESS_TOKEN'] = api_token

  req.set_form_data(activity_id: 'f4d9c08b-0639-43ca-93b3-009dac7fae8f', # does not matter in the current api
                    performed_on: date,
                    project_id: project_id,
                    reported_hours: reported_hours,
                    description: description)

  req = Net::HTTP.start(uri.hostname, uri.port, use_ssl: true) do |http|
    http.request(req)
  end

  puts req
end

def log_for_varner(date, reported_hours:, description:)
  upsert_activity_for_date(date, reported_hours: reported_hours, description: description, project_id: 525)
end

def log_for_sharefox(date, reported_hours:, description:)
  upsert_activity_for_date(date, reported_hours: reported_hours, description: description, project_id: 580)
end

def log_for_training(date, reported_hours:, description:)
  upsert_activity_for_date(date, reported_hours: reported_hours, description: description, project_id: 391)
end

def log_for_elp_meeting(date, reported_hours:, description:)
  upsert_activity_for_date(date, reported_hours: reported_hours, description: description, project_id: 15)
end

def calcualte_event_date(initial_date:, date_to_check:, event_interval:)
  if date_to_check < initial_date
    false
  elsif date_to_check == initial_date
    true
  else
    calcualte_event_date(initial_date: (initial_date + event_interval), date_to_check: date_to_check,
                         event_interval: event_interval)
  end
end

date = passed_date || Date.today

tuesday  = proc(&:tuesday?)
thursday = proc(&:thursday?)
wednesday = proc(&:wednesday?)
friday = proc(&:friday?)

AREK_KRZYSIEK = Date.parse('2021/03/09')
RETRO = Date.parse('2021/03/12')
BIWEEKLY = 14

def arek_krzysiek_date?(date)
  calcualte_event_date(initial_date: AREK_KRZYSIEK, date_to_check: date, event_interval: BIWEEKLY)
end

def retro_date?(date)
  calcualte_event_date(initial_date: RETRO, date_to_check: date, event_interval: BIWEEKLY)
end

def log_main_project(date, reported_hours:, description:)
  log_for_sharefox(date, reported_hours: reported_hours, description: description)
end

case date
when tuesday
  arek_meeting = arek_krzysiek_date?(date)
  main_activity_time = arek_meeting ? 7.5 : 8

  log_main_project(date, reported_hours: custom_activity_time || main_activity_time, description: activity_description)

  log_for_elp_meeting(date, reported_hours: 0.5, description: 'Arek/Krzysiek') if arek_meeting

when wednesday
  log_main_project(date, reported_hours: custom_activity_time || 7.0, description: activity_description)

  log_for_elp_meeting(date, reported_hours: 1, description: 'EL Churros sync')

when thursday
  log_main_project(date, reported_hours: custom_activity_time || 7.5, description: activity_description)

  log_for_elp_meeting(date, reported_hours: 0.5, description: 'Company SU')
# log_for_training(date, reported_hours: 1, description: 'AB')
# when friday
#   # retro_meeting = retro_date?(date)
#   # main_activity_time = retro_meeting ? 6.0 : 6.5
#
#   # log_for_varner(date, reported_hours: custom_activity_time || 0.5, description: 'Retro') if retro_meeting
#   # log_for_varner(date, reported_hours: custom_activity_time || 1, description: 'Grooming')
#   log_for_varner(date, reported_hours: custom_activity_time || main_activity_time, description: activity_description)
else
  log_main_project(date, reported_hours: custom_activity_time || 8, description: activity_description)
end
