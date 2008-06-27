module ConversionObserver
  @files_to_convert = []
  @files_to_check   = []
  
  class << self
    attr_reader :files_to_convert
    attr_reader :files_to_check
    
    def add_file_to_convert(file)
      @files_to_convert << file
      @files_to_convert.uniq!
    end
    
    def file_to_convert
      files_to_convert.shift
    end
    
    def add_file_to_check(file)
      @files_to_check << file
      @files_to_check.uniq!
    end
    
    
    private
    
    def clear_files_to_convert
      @files_to_convert = []
    end
    
    def clear_files_to_check
      @files_to_check = []
    end
  end
end

require 'conversion_observer/collector'
require 'conversion_observer/checker'
require 'conversion_observer/consumer'
