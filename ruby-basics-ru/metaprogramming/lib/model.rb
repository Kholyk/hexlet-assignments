# frozen_string_literal: true

module Model
  def self.included(base)
    base.extend ClassMethods
  end

  module ClassMethods
    def schema
      @schema ||= {}
    end

    def attribute(name, options)
      self.schema[name] = options

      define_method "#{name}" do
        instance_variable_get "@#{name}"
      end

      define_method "#{name}=" do |value|
        type = @schema[name][:type]
        instance_variable_set "@#{name}", self.convert(value, type)
      end
    end
  end

  def initialize(fields = {})
    @schema = self.class.schema
    @schema.keys.map do |key|
      self.method("#{key}=").call(fields[key] || @schema[key][:default])
    end
  end

  def attributes
    @schema
      .keys
      .each_with_object({}) { |key, acc| acc[key] = self.method("#{key}").call }
  end

  def convert(value, type = nil)
    return nil if value.nil?
    return value if type.nil?

    dispatch = {
      integer: -> (value) {value.to_i},
      string: -> (value) {value.to_s},
      datetime: -> (value) {DateTime.parse value},
      boolean: -> (value) {!!value}
    }

    dispatch[type].call value
  end
end