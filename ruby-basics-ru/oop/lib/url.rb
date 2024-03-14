# frozen_string_literal: true

# BEGIN
require 'forwardable'
require 'uri'

# Class URL
class Url
  include URI
  include Comparable
  extend Forwardable
  attr_reader :uri_string

  def initialize(uri_string)
    @uri_string = uri_string
    @uri = URI @uri_string
  end

  def_delegators :@uri, :scheme, :host

  def query_params
    query_string_mapping
  end

  def query_param(key, default = nil)
    query_string_mapping[key] || default
  end

  def <=>(other)
    @uri_string <=> other.uri_string
  end

  private

  def query_string_mapping
    return {} if @uri.query.nil?

    @uri.query.split('&').each_with_object({}) do |pair, acc|
      key, value = pair.split('=')
      acc[key.to_sym] = value
    end
  end
end
