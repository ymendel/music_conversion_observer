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
      @checker.stubs(:approve_files)
      @checker.stubs(:check_file)
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
  
  it 'should check files' do
    @checker.should respond_to(:check_files)
  end
  
  describe 'when checking files' do
    before :each do
      @files = Array.new(3) { |i|  stub("file #{i+1}") }
    end
    
    it 'should accept files' do
      lambda { @checker.check_files(@files) }.should_not raise_error(ArgumentError)
    end
    
    it 'should require files' do
      lambda { @checker.check_files }.should raise_error(ArgumentError)
    end
    
    it 'should check each file' do
      @files.each do |file|
        @checker.expects(:check_file).with(file)
      end
      
      @checker.check_files(@files)
    end
    
    it 'should return the files that checked out okay' do
      @files.each_with_index do |file, i|
        @checker.stubs(:check_file).with(file).returns((i%2).zero?)
      end
      
      @checker.check_files(@files).should == @files.values_at(0,2)
    end
  end
  
  it 'should check a file' do
    @checker.should respond_to(:check_file)
  end
  
  describe 'when checking a file' do
    before :each do
      @file = stub('file')
      File.stubs(:size)
    end
    
    it 'should accept a file' do
      lambda { @checker.check_file(@file) }.should_not raise_error(ArgumentError)
    end
    
    it 'should require a file' do
      lambda { @checker.check_file }.should raise_error(ArgumentError)
    end
    
    it 'should get the file size' do
      File.expects(:size).with(@file)
      @checker.check_file(@file)
    end
    
    describe 'when the file size has not been cached' do
      before :each do
        @checker.send(:clear_files)
        @size = stub('size')
        File.stubs(:size).with(@file).returns(@size)
      end
      
      it 'should return false' do
        @checker.check_file(@file).should be(false)
      end
      
      it 'should add the size to the cache' do
        @checker.check_file(@file)
        @checker.files[@file].should == @size
      end
    end
    
    describe 'when the file size has been cached' do
      before :each do
        @checker.send(:clear_files)
        @size = stub('size')
        @checker.files[@file] = @size
      end
            
      describe 'and the new file size is different' do
        before :each do
          @other_size = stub('other size')
          File.stubs(:size).with(@file).returns(@other_size)
        end
        
        it 'should return false' do
          @checker.check_file(@file).should be(false)
        end
        
        it 'should modify the cached size' do
          @checker.check_file(@file)
          @checker.files[@file].should == @other_size
        end
      end
      
      describe 'and the new file size is the same' do
        before :each do
          File.stubs(:size).with(@file).returns(@size)
        end
        
        it 'should return true' do
          @checker.check_file(@file).should be(true)
        end
        
        it 'should remove the cached size' do
          @checker.check_file(@file)
          @checker.files.should_not include(@file)
        end
      end
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
  
  it 'should approve files' do
    @checker.should respond_to(:approve_files)
  end
  
  describe 'when approving files' do
    before :each do
      @files = Array.new(3) { |i|  stub("file #{i+1}") }
      ConversionObserver.stubs(:remove_file_to_check)
      ConversionObserver.stubs(:add_file_to_convert)
    end
    
    it 'should accept files' do
      lambda { @checker.approve_files(@files) }.should_not raise_error(ArgumentError)
    end
    
    it 'should require files' do
      lambda { @checker.approve_files }.should raise_error(ArgumentError)
    end
    
    it 'should remove the files from the check queue' do
      @files.each do |file|
        ConversionObserver.expects(:remove_file_to_check).with(file)
      end
      
      @checker.approve_files(@files)
    end
    
    it 'should add the files to the convert queue' do
      @files.each do |file|
        ConversionObserver.expects(:add_file_to_convert).with(file)
      end
      
      @checker.approve_files(@files)
    end
  end
end
