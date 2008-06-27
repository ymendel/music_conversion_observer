require File.dirname(__FILE__) + '/spec_helper.rb'

describe ConversionObserver::Checker do
  before :each do
    @checker = ConversionObserver::Checker.new
  end
  
  it 'should run'
  
  describe 'when run' do
    it 'should get files to check'
    
    describe 'when there are files to check' do
      it 'should check files'
      it 'should approve the files that checked out okay'
      it 'should return true'
    end
    
    describe 'when there are no files to check' do
      it 'should return nil'
      it 'should not check files'
    end
  end
  
  it 'should check files'
  
  describe 'when checking files' do
    it 'should accept files'
    it 'should require files'
    
    it 'should check each file'
    it 'should return the files that checked out okay'
  end
  
  it 'should check a file'
  
  describe 'when checking a file' do
    it 'should accept a file'
    it 'should require a file'
    
    it 'should get the file size'
    it 'should compare the file size to the cached size'
    
    describe 'when the file size is the same' do
      it 'should return true'
      it 'should remove the cached size'
    end
    
    describe 'when the file size is different' do
      it 'should return false'
      it 'should leave the cached size'
    end
  end
  
  it 'should have a file cache' do
    @checker.should respond_to(:files)
  end
  
  describe 'file cache' do
    it 'should default to an empty hash' do
      @checker.files.should == {}
    end
  end
  
  it 'should approve files'
  
  describe 'when approving files' do
    it 'should accept files'
    it 'should require files'
    
    it 'should remove the files from the check queue'
    it 'should add the files to the convert queue'
  end
end
