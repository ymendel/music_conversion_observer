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
  
  it 'should convert'
  
  describe 'when converting' do
    it 'should accept a file'
    it 'should require a file'
    
    it 'should call the flac2mp3 command on the file'
    it 'should pass the --delete flag to flac2mp3'
  end
end
