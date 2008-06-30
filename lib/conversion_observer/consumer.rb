module ConversionObserver
  class Consumer
    def run
      file = ConversionObserver.file_to_convert
      
      if file
        convert(file)
        true
      end
    end
    
    def convert(file)
      system('flac2mp3', file, '--delete', '--silent')
    end
  end
end
