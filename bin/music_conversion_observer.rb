#!/usr/bin/env ruby

require 'rubygems'
require 'fsevents'

files_to_check = []
files_to_process = []

collector = Thread.new do
  begin
    stream = FSEvents::Stream.watch("#{ENV['HOME']}/Music/to convert") do |events|
      files_to_check += events.modified_files.select { |file|  file.match(/\.flac$/) }
      files_to_check.uniq!
    end
    stream.run
  rescue Interrupt
    stream.shutdown
  end
end

checker = Thread.new do
  files = {}
  
  loop do
    if files_to_check.empty?
      Thread.pass
    else
      finished_files = []
      
      files_to_check.each do |file|
        size = File.size(file)
        
        if files[file] == size
          finished_files << file
          files.delete(file)
        else
          files[file] = size
        end
      end
      
      files_to_check   -= finished_files
      files_to_process += finished_files
      files_to_process.uniq!
      
      sleep 0.5
    end
  end
end

consumer = Thread.new do
  loop do
    if files_to_process.empty?
      Thread.pass
    else
      system('flac2mp3', files_to_process.shift)
    end
  end
end

collector.join
checker.join
consumer.join
