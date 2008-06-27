require 'rubygems'
require 'fsevents'

module ConversionObserver
  class Collector
    attr_reader :stream
    
    def prepare
      @stream = FSEvents::Stream.watch("#{ENV['HOME']}/Music/to convert", &self.class.stream_callback)
    end
    
    class << self
      def stream_callback
        Proc.new do |events|
          events.modified_files.each do |file|
            ConversionObserver.add_file_to_check(file) if file.match(/\.flac$/)
          end
        end
      end
    end
    
    def run
      stream.run
    end
  end
end
