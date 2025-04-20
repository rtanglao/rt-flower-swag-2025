#!/usr/bin/env ruby
require 'rubygems'
require 'bundler/setup'
require 'json'
require 'curb'
require 'pp'
require 'time'
require 'date'
require 'open-uri'
require 'csv'

if ARGV.empty?
  puts "usage: #{$PROGRAM_NAME} <url of csv file>"
  exit
end

def fetch_1_at_a_time(urls_filenames)
  easy = Curl::Easy.new
  easy.follow_location = true

  urls_filenames.each do |url_fn|
    easy.url = url_fn['url']
    filename = url_fn['filename']
    $stderr.print "filename:'#{filename}'"
    $stderr.print "url:'#{url_fn['url']}'"
    if File.exist?(filename)
      $stderr.printf("skipping EXISTING filename:%s\n", filename)
      next
    end
    try_count = 0
    begin
      File.open(filename, 'wb') do |f|
        easy.on_progress do |_dl_total, _dl_now, _ul_total, _ul_now|
          $stderr.print '='
          true
        end
        easy.on_body do |data|
          f << data
          data.size
        end
        easy.perform
        warn "=> '#{filename}'"
      end
    rescue Curl::Err::ConnectionFailedError => e
      try_count += 1
      if try_count < 4
        $stderr.printf("Curl:ConnectionFailedError exception, retry:%d\n",\
                       try_count)
        sleep(10)
        retry
      else
        $stderr.printf("Curl:ConnectionFailedError exception, retrying FAILED\n")
        raise e
      end
    end
  end
end

urls_filenames = []

CSV.foreach(URI.open(ARGV[0]), headers: true).with_index do |p, i|
  id = p['id']
  title = p['title'].gsub('/', ' ')
  url = p['url_o']
  $stderr.printf("MISSING ORIGINAL URL: photo id:#{id}, title:#{title} IS NIL\n") if url.nil?
  title = title[0..63] if title.length > 64
  filename = format(
    '%<index>4.4d-%<id>d-%<title>s-original-%<width>4.4d-%<height>4.4d.jpg',
    id: id, title: title, width: p['o_width'], height: p['o_height'], index: i
  )
  $stderr.printf("photo:#{id}, title:#{title} url:#{url} filename:#{filename}\n")
  urls_filenames.push({ 'url' => url, 'filename' => filename }) unless url.nil?
end

$stderr.printf("FETCHING:%d originals\n", urls_filenames.length)
fetch_1_at_a_time(urls_filenames)
