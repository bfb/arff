module Arff
  class Attribute
    TYPES = {
      'NUMERIC' => Numeric,
      'REAL' => Float,
      'INTEGER' => Integer,
      'STRING' => String,
      'DATE' => Date
    }

    def initialize(name, type)
      fail Arff::Errors::InvalidAttribute.new "Attribute type should be NUMERIC, INTEGER, REAL, STRING, DATE or a nominal." if !type.is_a?(Array) && !TYPES.keys.include?(type)

      self.name = name
      self.type = type
    end

    attr_accessor :name, :type

    def is_nominal?
      self.type.is_a?(Array)
    end

    def to_arff
      # mount nominal attribute
      type_arff = if self.is_nominal?
                    "{#{self.type.join(',')}}"
                  else
                    self.type
                  end

      "@attribute #{self.name} #{type_arff}"
    end

  end
end
