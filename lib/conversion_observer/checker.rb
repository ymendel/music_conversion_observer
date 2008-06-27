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
  end
end
