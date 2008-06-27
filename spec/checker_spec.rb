require File.dirname(__FILE__) + '/spec_helper.rb'

describe ConversionObserver::Checker do
  before :each do
    @checker = ConversionObserver::Checker.new
  end
  
  it 'should run' do
    @checker.should respond_to(:run)
  end
  
  describe 'when run' do
    before :each do
      @checker.stubs(:check_files)
      @checker.stubs(:approve_files)
    end
    
    it 'should get files to check' do
      ConversionObserver.expects(:files_to_check).returns([])
      @checker.run
    end
    
    describe 'when there are files to check' do
      before :each do
        @files = Array.new(3) { |i|  stub("file #{i+1}") }
        ConversionObserver.stubs(:files_to_check).returns(@files)
      end
      
      it 'should check files' do
        @checker.expects(:check_files).with(@files)
        @checker.run
      end
      
      it 'should approve the files that checked out okay' do
        @okay_files = stub('okay files')
        @checker.stubs(:check_files).returns(@okay_files)
        @checker.expects(:approve_files).with(@okay_files)
        @checker.run
      end
      
      it 'should return true' do
        @checker.run.should be(true)
      end
    end
    
    describe 'when there are no files to check' do
      before :each do
        ConversionObserver.stubs(:files_to_check).returns([])
      end
      
      it 'should return nil' do
        @checker.run.should be_nil
      end
      
      it 'should not check files' do
        @checker.expects(:check_files).never
        @checker.run
      end
      
      it 'should not approve files' do
        @checker.expects(:approve_files).never
        @checker.run
      end
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
