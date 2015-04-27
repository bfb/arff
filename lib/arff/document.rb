module Arff
  class Document < Base
    def initialize(name, attributes=[], instances=[])
      self.name = name
      self.attributes = attributes
      self.instances = instances
    end

    attr_accessor :name, :attributes, :instances

    def add_attribute(attribute)
      self.attributes << Attribute.new(attribute[:name], attribute[:type])
    end

    def add_attributes(attributes)
      attributes.each {|h| self.add_attribute(h) }
    end

    def add_instance(*instance)
      self.instances << Instance.new(instance, attributes)
    end

    def add_instances(instances)
      instances.each {|t| self.add_instance(t) }
    end

  end
end
