require File.dirname(__FILE__) + '/spec_helper.rb'

describe ConversionObserver::Consumer do
  before :each do
    @consumer = ConversionObserver::Consumer.new
  end
  
  it 'should run' do
    @consumer.should respond_to(:run)
  end
  
  describe 'when running' do
    it 'should request a file to convert' do
      ConversionObserver.expects(:file_to_convert)
      @consumer.run
    end
    
    describe 'when there is a file to convert' do
      before :each do
        @file = stub('file')
        ConversionObserver.stubs(:file_to_convert).returns(@file)
        @consumer.stubs(:convert)
      end
      
      it 'should convert the file' do
        @consumer.expects(:convert).with(@file)
        @consumer.run
      end
      
      it 'should return true' do
        @consumer.run.should be(true)
      end
    end
    
    describe 'when there is no file to convert' do
      before :each do
        ConversionObserver.stubs(:file_to_convert).returns(nil)
      end
      
      it 'should return nil' do
        @consumer.run.should be_nil
      end
      
      it 'should not convert' do
        @consumer.expects(:convert).never
        @consumer.run
      end
    end
  end
  
  it 'should convert' do
    @consumer.should respond_to(:convert)
  end
  
  describe 'when converting' do
    before :each do
      @file = 'filename'
      @consumer.stubs(:system)
    end
    
    it 'should accept a file' do
      lambda { @consumer.convert(@file) }.should_not raise_error(ArgumentError)
    end
    
    it 'should require a file' do
      lambda { @consumer.convert }.should raise_error(ArgumentError)
    end
    
    it 'should call the flac2mp3 command on the file' do
      @consumer.expects(:system).with('flac2mp3', @file, anything, anything)
      @consumer.convert(@file)
    end
    
    it 'should pass the --delete flag to flac2mp3' do
      @consumer.expects(:system).with('flac2mp3', anything, '--delete', anything)
      @consumer.convert(@file)
    end
    
    it 'should pass the --silent flag to flac2mp3' do
      @consumer.expects(:system).with('flac2mp3', anything, anything, '--silent')
      @consumer.convert(@file)
    end
  end
end
