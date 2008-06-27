module ConversionObserver
  class Consumer
    def convert(file)
      system('flac2mp3', '--delete', file)
    end
  end
end
