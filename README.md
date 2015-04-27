# ARFF Ruby parser

An ARFF (Attribute-Relation File Format) file is an ASCII text file that describes a list of instances sharing a set of attributes.

Check out details about the ARFF structure in this link <a href="http://www.cs.waikato.ac.nz/ml/weka/arff.html">http://www.cs.waikato.ac.nz/ml/weka/arff.html</a>.

## Usage

### Creating an ARFF file

Initialize an ARFF document.

    doc = Arff::Document.new('Cars')

Add attributes to the document. You can add each attribute separately or together.

    doc.add_attribute({ name: 'brand', type: 'STRING' })
    doc.add_attributes([
                          { name: 'model', type: 'STRING' },
                          { name: 'top_speed', type: 'NUMERIC'}
                          { name: 'color', type: ['White', 'Black', 'Silver', 'Red']}
                        ])

Add some instances to the document.

    doc.add_instance('BMW', 'BMW 4 Series Coupé', 'White')
    doc.add_instances([['Aston Martin', 'V8 Vantage SP10', 'Black'], ['Dodge', 'Challenger', 'Red']])

You can access all document structure as objects.

    doc.attributes
    # returns an array of Arff::Attribute objects
    doc.instances
    # returns an array of Arff::Instance objects

You can access the instance attributes.

    instance = doc.instances.first
    instance.brand # 'BMW'
    instance.model # 'BMW 4 Series Coupé'
    instance.color # 'White'

You can generate the ARFF file with 3 lines of code.

    file = File.new('my_doc.arff', 'wb')
    file.write = doc.to_arff
    file.close

### Parsing an ARFF file

    doc = Arff::Document.parse('./my_doc.arff')

* Parser not completed yet.

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
