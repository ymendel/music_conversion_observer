module ConversionObserver
  @files_to_convert = []
  
  class << self
    attr_reader :files_to_convert
    
    def add_file_to_convert(file)
      @files_to_convert << file
      @files_to_convert.uniq!
    end
    
    def file_to_convert
      files_to_convert.shift
    end
    
    
    private
    
    def clear_files_to_convert
      @files_to_convert = []
    end
  end
end

require 'conversion_observer/consumer'
