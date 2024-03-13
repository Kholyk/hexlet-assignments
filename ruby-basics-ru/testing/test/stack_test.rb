# frozen_string_literal: true

require_relative 'test_helper'
require_relative '../lib/stack'

class StackTest < Minitest::Test
  # BEGIN
  def setup
    @stack = Stack.new %w[first second third fourth]
  end

  def test_output_should_be_array
    assert @stack.to_a.instance_of? Array
  end

  def test_size_of_stack
    assert @stack.size == 4
    @stack.push! 'test'
    assert @stack.size == 5
    @stack.pop!
    assert @stack.size == 4
  end

  def test_push_method
    @stack.push! 'added'
    assert @stack.size == 5
    assert @stack.to_a.last == 'added'
  end

  def test_pop_method
    *, last_before = @stack.to_a
    last = @stack.pop!
    assert @stack.size == 3
    assert @stack.to_a.last == 'third'
    assert last == last_before
  end

  def test_clear_method
    @stack.clear!
    assert @stack.size.zero?
    assert @stack.to_a.empty?
  end

  def test_empty_predicate
    @stack.clear!
    assert @stack.empty?
    assert @stack.to_a.empty?
  end
  # END
end

test_methods = StackTest.new({}).methods.select { |method| method.start_with? 'test_' }
raise 'StackTest has not tests!' if test_methods.empty?
