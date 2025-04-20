#!/usr/bin/env ruby
require 'rubygems'
require 'bundler/setup'
require 'json'
require 'pp'
require 'time'
require 'date'
require 'parseconfig'
require 'typhoeus'
require 'awesome_print'
require 'csv'
require 'json_converter'

# might not work if you take more than 4000 photos :-)
# https://www.flickr.com/services/api/flickr.photosets.getPhotos.html
# Please note that Flickr will return at most the first 4,000 results for any given search query.
# If this is an issue, we recommend trying a more specific query.

def getFlickrResponse(url, params, _logger)
  url = 'https://api.flickr.com/' + url
  try_count = 0
  begin
    result = Typhoeus::Request.get(url,
                                   params: params)
    x = JSON.parse(result.body)
  # logger.debug x["photos"].ai
  rescue JSON::ParserError
    try_count += 1
    if try_count < 4
      $stderr.printf("JSON::ParserError exception, retry:%d\n",\
                     try_count)
      sleep(10)
      retry
    else
      $stderr.printf("JSON::ParserError exception, retrying FAILED\n")
      x = nil
    end
  end
  x
end

JsonConverter.new
logger = Logger.new(STDERR)
logger.level = Logger::DEBUG

flickr_config = ParseConfig.new('flickr.conf').params
api_key = flickr_config['api_key']

if ARGV.length < 1
  puts "usage: #{$PROGRAM_NAME} photosetid"
  exit
end

extras_str = 'description, license, date_upload, date_taken, owner_name, icon_server,\
             original_format, last_update, geo, tags, machine_tags, o_dims, views,\
             media, path_alias, url_sq, url_t, url_s, url_m, url_z, url_l, url_o,\
             url_c, url_q, url_n, url_k, url_h, url_b'

search_url = 'services/rest/'
csv_array = []
page = 1
photoset_id = ARGV[0]
loop do
  url_params = { method: 'flickr.photosets.getPhotos',
                 api_key: api_key,
                 format: 'json',
                 nojsoncallback: '1',
                 photoset_id: photoset_id,
                 user_id: '35034347371@N01',
                 #content_type: '7', # all: photos, videos, etc
                 extras: extras_str,
                 sort: 'date-taken-asc',
                 per_page: 250,
                 page: page.to_s }
  response = getFlickrResponse(search_url, url_params, logger)
  photos_on_this_page = response['photoset']

  ap photos_on_this_page
  $stderr.printf("RETRIEVING page : #{page}")
  $stderr.printf("STATUS from flickr API:%s retrieved page:%d of:%d\n", response['stat'],
                 photos_on_this_page['page'].to_i, photos_on_this_page['pages'].to_i)
  photos_on_this_page['photo'].each do |photo|
    $stderr.printf("PHOTO datetaken from flickr API:%s\n", photo['datetaken'])
    skip = false
    begin
      datetaken = Time.parse(photo['datetaken'])
    rescue ArgumentError
      $stderr.printf("Parser EXCEPTION in date:%sSKIPPED\n", photo['datetaken'])
      skip = true
    end
    next if skip

    datetaken = datetaken.utc
    $stderr.printf("PHOTO datetaken:%s\n", datetaken)
    photo['datetaken'] = datetaken
    dateupload = Time.at(photo['dateupload'].to_i)
    $stderr.printf("PHOTO dateupload:%s\n", dateupload)
    photo['dateupload'] = dateupload
    lastupdate = Time.at(photo['lastupdate'].to_i)
    $stderr.printf("PHOTO lastupdate:%s\n", lastupdate)
    photo['lastupdate'] = lastupdate
    photo['id'] = photo['id'].to_i
    id = photo['id']
    logger.debug 'PHOTO id:' + id.to_s
    logger.debug photo.ai
    photo['description_content'] = photo['description']['_content']
    photo_without_nested_stuff = photo.except('description')
    csv_array.push(photo_without_nested_stuff)
    # logger.debug photo.except("description").ai
    puts photo_without_nested_stuff
  end

  page += 1
  $stderr.printf("incremented page to: #{page}\n")
  break if page > photos_on_this_page['pages']
end

headers = csv_array[0].keys
# headers = [
FILENAME = format('photoset-%s-metadata.csv',
                  ARGV[0].to_i)
CSV.open(FILENAME, 'w', write_headers: true, headers: headers) do |csv_object|
  csv_array.each { |row_array| csv_object << row_array }
end
