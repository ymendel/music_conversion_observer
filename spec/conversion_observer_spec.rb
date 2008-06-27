require File.dirname(__FILE__) + '/spec_helper.rb'

describe ConversionObserver do
  it 'should give a file to convert' do
    ConversionObserver.should respond_to(:file_to_convert)
  end
end
