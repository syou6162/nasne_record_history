# coding: utf-8
require "icalendar"
require "json"

def num_with_padding(num)
  num.to_s.rjust(2, '0')
end

def make_time_str(t)
  tmp = "#{t.year}-#{num_with_padding t.month}-#{num_with_padding t.day}"
  return "#{tmp} #{num_with_padding t.hour}:#{num_with_padding t.minute}:#{num_with_padding t.second} +0900"
end

ical_src = IO.read("/Users/yasuhisa/Dropbox/nasne.ics")
cal = Icalendar.parse(ical_src, true)

index = "nasne_record_history"
type = "log"

cal.events.each do |event|
  title = event.summary
  s = make_time_str event.dtstart
  e = make_time_str event.dtend
  result = {:title => title, :start => s, :end => e}
  puts "{ \"index\" : { \"_index\" : \"#{index}\", \"_type\" : \"#{type}\", \"_id\" : \"#{s}_#{e}\" } }"
  puts result.to_json
end
