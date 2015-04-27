require File.expand_path('test/test_helper')

describe Arff::Attribute do

  it "should not allow invalid attributes types" do
    proc {
      Arff::Attribute.new('Brand', 'WORD')
    }.must_raise(Arff::Errors::InvalidAttribute)
  end

  it "should create a nominal attribute" do
    attribute = Arff::Attribute.new('Color', ['White', 'Black'])
    attribute.is_nominal?.must_equal true
    attribute.type.must_equal ['White', 'Black']
  end

end
