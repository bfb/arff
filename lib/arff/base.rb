module Arff
  class Base
    def to_arff
      arff = ""
      arff << "@relation #{self.name}\n"

      self.attributes.each do |attribute|
        arff << "#{attribute.to_arff}\n"
      end

      arff << "\n"
      arff << "@data\n"
      arff << "%\n"
      arff << "% #{self.instances.size}\n"
      arff << "%\n"
      arff << "\n"

      self.instances.each do |instance|
        arff << "#{instance.to_arff}\n"
      end

      arff
    end

    def self.parse(file_path)
      content = File.open(file_path).read
      doc = nil

      content.split("\n").each do |line|
        if line =~ /@relation/i
          doc = Arff::Document.new(line.split(' ')[1..-1].join(' '))
        elsif line =~ /@attribute/i
          line = line.squeeze.split(' ')
          type = line[2..-1].join('')
          doc.add_attribute({ name: line[1], type: type =~ /\{.*\}/i ? type.sub('{', '').sub('}', '').split(',') : type })
        elsif line[0] != '%' && line.size > 0 && !(line =~ /@data/i)
          # trait 'some value, other thing'
          doc.add_instance(line.split(','))
        end
      end

      doc
    end
  end
end
