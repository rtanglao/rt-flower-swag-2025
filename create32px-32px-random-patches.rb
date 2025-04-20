#!/usr/bin/env ruby
require 'json'
require 'rubygems'
require 'awesome_print'
require 'json'
require 'time'
require 'date'
require 'csv'
require 'logger'
require 'open3'

logger = Logger.new(STDERR)
logger.level = Logger::DEBUG

if ARGV.length < 2
  puts "usage: #{$PROGRAM_NAME} [filenames-of-3424x3424px originals] [number of 32px_32px patches]"
  exit
end

FILENAME = ARGV[0]
number_of_patches = ARGV[1].to_i

filenames = File.readlines(FILENAME, chomp: true)
MAX_X_INDEX = 3424 / 32 - 1
MAX_Y_INDEX = MAX_X_INDEX
length_of_file_array = filenames.length
number_of_patches.times do |_i|
  file_index = rand(length_of_file_array)
  file = filenames[file_index]
  x_offset = rand(MAX_X_INDEX) * 32
  y_offset = rand(MAX_Y_INDEX) * 32
  ap file
  filebasename = File.basename(file, '.jpg')
  filename = format(
    '%<basename>s-32x32patch-%<x_offset>4.4d-%<y_offset>4.4d.png',
    basename: filebasename, x_offset: x_offset,
    y_offset: y_offset
  )
  if File.exist?(filename)
    logger.debug "skipping EXISTING filename:#{filename}"
    next
  end
  magick_offset_str = format(
    '32x32+%<x_offset>d+%<y_offset>d',
    x_offset: x_offset, y_offset: y_offset
  )
  logger.debug "FILENAME: #{filename}"
  magick_command_line = "magick #{file} -crop #{magick_offset_str} +repage #{filename}"
  logger.debug "magick command line: #{magick_command_line}"
  Open3.popen2e(magick_command_line) do |stdin, stdout_stderr, wait_thread|
    Thread.new do
      stdout_stderr.each { |l| puts l }
    end
    stdin.close
    wait_thread.value
  end
end
