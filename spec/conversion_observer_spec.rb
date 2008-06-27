require File.dirname(__FILE__) + '/spec_helper.rb'

describe ConversionObserver do
  it 'should have files to convert' do
    ConversionObserver.should respond_to(:files_to_convert)
  end
  
  it 'should add a file to convert' do
    ConversionObserver.should respond_to(:add_file_to_convert)
  end
  
  it 'should give a file to convert' do
    ConversionObserver.should respond_to(:file_to_convert)
  end
    
  describe 'files to convert' do
    it 'should default to an empty array' do
      ConversionObserver.files_to_convert.should == []
    end
    
    describe 'when added' do
      before :each do
        ConversionObserver.send(:clear_files_to_convert)
      end
      
      it 'should be in the returned array' do
        @file = stub('file')
        ConversionObserver.add_file_to_convert(@file)
        ConversionObserver.files_to_convert.should == [@file]
      end
      
      it 'should add to the end of the array' do
        @file = stub('file')
        @other_file = stub('other file')
        ConversionObserver.add_file_to_convert(@file)
        ConversionObserver.add_file_to_convert(@other_file)
        ConversionObserver.files_to_convert.should == [@file, @other_file]
      end
      
      it 'should remove duplicates' do
        @file = stub('file')
        ConversionObserver.add_file_to_convert(@file)
        ConversionObserver.add_file_to_convert(@file)
        ConversionObserver.files_to_convert.should == [@file]
      end
    end
    
    describe 'when retrieved' do
      before :each do
        ConversionObserver.send(:clear_files_to_convert)
        @file  = stub('file')
        @files = [@file] + Array.new(3) { |i|  stub("file #{i+1}") }
        @files.each { |file|  ConversionObserver.add_file_to_convert(file) }
      end
      
      it 'should return the first file in the array' do
        ConversionObserver.file_to_convert.should == @file
      end
      
      it 'should remove the file from the array' do
        ConversionObserver.file_to_convert
        ConversionObserver.files_to_convert.should == @files[1..-1]
      end
      
      it 'should return nil if the array is empty' do
        ConversionObserver.send(:clear_files_to_convert)
        ConversionObserver.file_to_convert.should be_nil
      end
    end
  end
  
  it 'should have files to check' do
    ConversionObserver.should respond_to(:files_to_check)
  end
  
  it 'should add a file to check' do
    ConversionObserver.should respond_to(:add_file_to_check)
  end
    
  describe 'files to check' do
    it 'should default to an empty array' do
      ConversionObserver.files_to_check.should == []
    end
    
    describe 'when added' do
      before :each do
        ConversionObserver.send(:clear_files_to_check)
      end
      
      it 'should be in the returned array' do
        @file = stub('file')
        ConversionObserver.add_file_to_check(@file)
        ConversionObserver.files_to_check.should == [@file]
      end
      
      it 'should add to the end of the array' do
        @file = stub('file')
        @other_file = stub('other file')
        ConversionObserver.add_file_to_check(@file)
        ConversionObserver.add_file_to_check(@other_file)
        ConversionObserver.files_to_check.should == [@file, @other_file]
      end
      
      it 'should remove duplicates' do
        @file = stub('file')
        ConversionObserver.add_file_to_check(@file)
        ConversionObserver.add_file_to_check(@file)
        ConversionObserver.files_to_check.should == [@file]
      end
    end
  end
end
