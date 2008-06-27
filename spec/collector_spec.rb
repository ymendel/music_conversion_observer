require File.dirname(__FILE__) + '/spec_helper.rb'

describe ConversionObserver::Collector do
  before :each do
    @collector = ConversionObserver::Collector.new
  end
  
  it 'should add prepare itself' do
    @collector.should respond_to(:prepare)
  end
  
  describe 'preparing itself' do
    before :each do
      @proc = Proc.new {}
      ConversionObserver::Collector.stubs(:stream_callback).returns(@proc)
    end
    
    it 'should create an fsevents stream' do
      FSEvents::Stream.expects(:watch)
      @collector.prepare
    end
    
    it 'should create a stream for the music conversion directory' do
      FSEvents::Stream.expects(:watch).with("#{ENV['HOME']}/Music/to convert")
      @collector.prepare
    end
    
    it 'should store the stream' do
      stream = stub('stream')
      FSEvents::Stream.stubs(:watch).returns(stream)
      @collector.prepare
      @collector.stream.should == stream
    end
  end
  
  it 'should have a stream callback' do
    ConversionObserver::Collector.should respond_to(:stream_callback)
  end
  
  describe 'stream callback' do
    it 'should return a proc' do
      ConversionObserver::Collector.stream_callback.should be_kind_of(Proc)
    end
    
    describe 'proc' do
      before :each do
        ConversionObserver.stubs(:add_file_to_check)
        @files = Array.new(3) { |i|  "file_#{i+1}.flac" }
        @events = stub('events', :modified_files => @files)
        @proc = ConversionObserver::Collector.stream_callback
      end
      
      it 'should accept events' do
        lambda { @proc.call(@events) }.should_not raise_error(ArgumentError)
      end
      
      it 'should get the modified files for the events' do
        @events.expects(:modified_files).returns([])
        @proc.call(@events)
      end
      
      it 'should add the modified files to be checked' do
        @files.each do |file|
          ConversionObserver.expects(:add_file_to_check).with(file)
        end
        
        @proc.call(@events)
      end
      
      it 'should only add FLAC files' do
        file = 'nonflac_file.txt'
        @files.push(file)
        ConversionObserver.expects(:add_file_to_check).with(file).never
        
        @proc.call(@events)
      end
    end
  end
  
  it 'should run' do
    @collector.should respond_to(:run)
  end
  
  describe 'when running' do
    before :each do
      @stream = stub('stream')
      @collector.stubs(:stream).returns(@stream)
    end
    
    it 'should run the stream' do
      @stream.expects(:run)
      @collector.run
    end
  end
end
