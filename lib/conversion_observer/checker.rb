module ConversionObserver
  class Checker
    attr_reader :files
    
    def initialize
      @files = {}
    end
    
    def run
      files_to_check = ConversionObserver.files_to_check
      
      unless files_to_check.empty?
        okay_files = check_files(files_to_check)
        approve_files(okay_files)
        true
      end
    end
    
    def check_files(files)
      files.select { |file|  check_file(file) }
    end
    
    def check_file(file)
      size = File.size(file)
      
      if files[file] == size
        files.delete(file)
        true
      else
        files[file] = size
        false
      end
    end
    
    
    private
    
    def clear_files
      @files = {}
    end
  end
end
