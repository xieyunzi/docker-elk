#!/usr/bin/env ruby
# encoding: utf-8
#
# usage:
# LOGSTASH_IP=xxx ./nmap-data.rb

top_sites_filename = File.dirname(File.expand_path(__FILE__)) + '/top_sites.txt'

puts 'top_sites_filename: ' + top_sites_filename
puts 'File.exist?(top_sites_filename): ' + File.exist?(top_sites_filename).to_s

File.exist?(top_sites_filename) || `scrapy runspider top_site.py`
logstash_ip = ENV['LOGSTASH_IP'] || `docker-machine ip xyz`

File.read(top_sites_filename).split.each do |host|
  puts `nmap -sV #{host} -oX - | curl -H "x-nmap-target: #{host}" http://#{logstash_ip}:5001 -d @-`
end
