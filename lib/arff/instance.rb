require 'ostruct'

module Arff

  class Instance < OpenStruct

    def initialize(instance, attributes)
      instance_attributes = {}

      instance.each_with_index do |v, i|
        type = attributes[i].type
        name = attributes[i].name

        if type.is_a?(String)
          fail Arff::Errors::InvalidAttribute.new "Invalid instance: attribute #{v} should be #{type}." unless v.is_a?(Attribute::TYPES[type])
        else
          fail Arff::Errors::InvalidAttribute.new  "Invalid instance: attribute #{v} should be a valid nominal #{type}." unless type.include?(v)
        end

        instance_attributes[name] = v
      end

      super instance_attributes
    end

    def to_arff
      instance = ""

      self.marshal_dump.each do |k,v|
        instance <<  if v.is_a?(String)
                    "'#{v}',"
                  elsif v.nil?
                    "?,"
                  else
                    "#{v},"
                  end

      end

      instance.remove_last
    end
  end
end
