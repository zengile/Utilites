#!/usr/bin/env ruby
def gem_available?(name)
  Gem::Specification.find_by_name(name)
rescue Gem::LoadError
  false
rescue
  Gem.available?(name)
end

unless gem_available?("colorize")
  puts "Please install gem colorize first:"
  puts "gem install colorize"
  exit
end
require 'colorize'
require 'net/http'
require 'uri'


sites = ["booq.pro","railscasts.ru","ip.railscasts.ru","q3.railscasts.ru","ansever.booq.pro","menutka.com"]

def get_code(url)
  resp = Net::HTTP.get_response(URI.parse(url))
  print "."
  return resp.code
end

sites.map!{|s| "http://" + s}

print "Processing "
sites.map!{|s| {:site => s, :code => get_code(s)}; }.sort!{|x,y| x[:code].to_i <=> y[:code].to_i}
puts " done"

sites.each do |hash|
  code = hash[:code]
  site = hash[:site]
  case
  when code == "200" || code == "302"
    message = "[OK]".colorize( :light_green )
  when code[0] == '5'
    message = "[FAIL]".colorize( :light_red )
    fail = true
  else
    message = "[#{code}]".colorize( :light_yellow )
  end
  puts "#{message}\t:\t#{(fail)? site.colorize( :light_red ) : site.colorize( :white )}"
end
