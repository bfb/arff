require File.expand_path('test/test_helper')

describe Arff::Document do

  before do
    attributes = [Arff::Attribute.new('model', 'STRING'), Arff::Attribute.new('top_speed', 'NUMERIC')]
    @instance = Arff::Instance.new(['BMW 4 Series Coupe', 250], attributes)
  end

  it "should intialize a instance" do
    @instance.model.must_equal 'BMW 4 Series Coupe'
    @instance.top_speed.must_equal 250
  end

  it "should generate the instance dump" do
    @instance.to_arff.must_equal "'BMW 4 Series Coupe',250"
  end

end
