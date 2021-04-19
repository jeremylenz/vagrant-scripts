#!/usr/bin/ruby

new_ip = ARGV[0]
hostname = ARGV[1] || 'centos7-katello-devel'
file_path = ARGV[2] || '/etc/hosts'

puts ARGV.inspect
puts "updating IP of #{hostname} to #{new_ip} in #{file_path}..."

def replace_ip(line, new_ip)
  ip_regex = /\b(?:[0-9]{1,3}\.){3}[0-9]{1,3}\b/
  line.gsub(ip_regex, new_ip)
end

lines = IO.readlines(file_path).map do |line|
  line = replace_ip(line, new_ip) if line.split(' ').include?(hostname)
  line
end

File.open(file_path, 'w') do |file|
  file.puts lines
end

puts 'done!'
