require File.dirname(__FILE__) + '/spec_helper.rb'

describe ConversionObserver::Consumer do
  before :each do
    @consumer = ConversionObserver::Consumer.new
  end
  
  it 'should run'
  
  describe 'when running' do
    it 'should request a file to convert'
    
    describe 'when there is a file to convert' do
      it 'should convert the file'
    end
    
    describe 'when there is no file to convert' do
      it 'should pass'
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
      @consumer.expects(:system).with('flac2mp3', anything, @file)
      @consumer.convert(@file)
    end
    
    it 'should pass the --delete flag to flac2mp3' do
      @consumer.expects(:system).with('flac2mp3', '--delete', anything)
      @consumer.convert(@file)
    end
  end
end
