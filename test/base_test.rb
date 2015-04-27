require File.expand_path('test/test_helper')

describe Arff::Base do

  before do
    @document = Arff::Document.new('Cars')
    @document.add_attribute({ name: 'brand', type: 'STRING'})
    @document.add_attribute({ name: 'model', type: 'STRING'})
    @document.add_attribute({ name: 'colors', type: ['White', 'Black', 'Silver', 'Red'] })
    @document.add_instance('BMW', 'M3 Coupe', 'White')
  end

  it "should generate the arff string" do
    @document.to_arff.must_equal <<-EOF
@relation Cars
@attribute brand STRING
@attribute model STRING
@attribute colors {White,Black,Silver,Red}

@data
%
% 1
%

'BMW','M3 Coupe','White'
    EOF
  end
end
