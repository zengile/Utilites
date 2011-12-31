#!/usr/bin/env ruby
require 'net/http'
require 'uri'
require 'colorize'


sites = ["booq.pro","railscasts.ru","ip.railscasts.ru","q3.railscasts.ru","ansever.booq.pro","menutka.com"]

def get_code(url)
  resp = Net::HTTP.get_response(URI.parse(url))
  return resp.code
end

sites.map!{|s| "http://" + s}

puts "Processing ..."
sites.map!{|s| {:site => s, :code => get_code(s)} }.sort!{|x,y| x[:code].to_i <=> y[:code].to_i}

sites.each do |hash|
  code = hash[:code]
  site = hash[:site]
  case
  when code == "200" || code == "302"
    message = "[OK]".colorize( :light_green )
  when code[0] == '5'
    message = "[FAIL]".colorize( :light_red )
  else
    message = "[#{code}]".colorize( :light_yellow )
  end
  puts "#{message}\t:\t#{site}"
end
