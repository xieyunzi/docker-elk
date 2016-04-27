#!/usr/bin/env ruby
# encoding: utf-8
#
# usage:
# LOGSTASH_IP=xxx ./nmap-data.rb

top_sites_filename = 'top_sites.txt'
logstash_ip = ENV['LOGSTASH_IP'] || `docker-machine ip xyz`

File.exist?(top_sites_filename) || `scrapy runspider top_site.py`

File.read(top_sites_filename).split.each do |host|
  `nmap -sV #{host} -oX - | curl -H "x-nmap-target: #{host}" http://#{logstash_ip}:5001 -d @-`
end
