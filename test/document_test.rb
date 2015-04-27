require File.expand_path('test/test_helper')

describe Arff::Document do

  before do
    @document = Arff::Document.new('Cars')
    @document.add_attribute({ name: 'brand', type: 'STRING'})
    @document.add_attribute({ name: 'model', type: 'STRING'})
    @document.add_attribute({ name: 'colors', type: ['White', 'Black', 'Silver', 'Red'] })
  end

  it "should set a single attribute" do
    @document.add_attribute({ name: 'model', type: 'STRING' })
    @document.attributes.size.must_equal 4

    model = @document.attributes.last
    model.name.must_equal 'model'
    model.type.must_equal 'STRING'
  end

  it "should set multiple attributes" do
    @document.add_attributes([
                            { name: 'HP', type: 'NUMERIC' },
                            { name: 'Engine', type: 'STRING' }
                          ])

    @document.attributes.size.must_equal 5
  end

  it "should allow nominals attributes" do
    @document.add_attribute({ name: 'colors', type: ['White', 'Black', 'Silver', 'Red'] })
    @document.attributes.last.type.must_equal ['White', 'Black', 'Silver', 'Red']
  end

  it "should insert a valid instance" do
    @document.add_instance('BMW', 'BMW 4 Series Coupé', 'White')

    @document.instances.size.must_equal 1
  end

  it "should not insert an invalid instance" do
    proc {
      @document.add_instance('BMW', 'BMW 4 Series Coupé', 'Yellow')
    }.must_raise(Arff::Errors::InvalidAttribute)

    proc {
      @document.add_instance('BMW', 2.0, 'Black')
    }.must_raise(Arff::Errors::InvalidAttribute)
  end

  it "should generate the arff string" do
    @document.add_instance('BMW', 'BMW 4 Series Coupe', 'White')

    @document.to_arff.must_equal <<-EOF
@relation Cars
@attribute brand STRING
@attribute model STRING
@attribute colors {White,Black,Silver,Red}

@data
%
% 1
%

'BMW','BMW 4 Series Coupe','White'
    EOF
  end

  it "should parse an ARFF document" do
    skip "Not impemented yet"
    doc = Arff::Document.parse('./test/fixture.arff')
    doc.instances.size.must_equal 9
  end

end
