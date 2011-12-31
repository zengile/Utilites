#!/usr/bin/env ruby
require 'net/http'
require 'uri'

def get_code(url)
  resp = Net::HTTP.get_response(URI.parse(url))
  return resp.code
end

sites = ["booq.pro","railscasts.ru","ip.railscasts.ru","q3.railscasts.ru","ansever.booq.pro"]
sites.map!{|s| "http://" + s}

sites.each do |site|
  code = get_code(site)
  case
  when code == "200" || code == "302"
    message = "[OK]"
  when code[0] == '5'
    message = "[FAIL]"
  else
    message = "[#{code}]"
  end
  puts "#{message}\t:\t#{site}"
end
