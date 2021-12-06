# Shared Advent of Code Utilities
# frozen_string_literal: true

require 'set'

# IO ##################################################################

def read_lines(file_path)
  File.readlines(file_path).map(&:strip).reject(&:empty?)
end

def read_paragraphs(file_path)
  File.readlines(file_path).map(&:strip)
      .chunk { |line| line.empty? }
      .filter { |b, _| !b }.map { |_, a| a }
      .to_a
end

# Strings ##############################################################

def to_symbol(string)
  string.strip.gsub(' ', '_').to_sym
end

# Utilities ############################################################

def deep_copy(marshalable)
  Marshal.load(Marshal.dump(marshalable))
end

# Binary ###############################################################

# Translate a string representation of a bitfield to an integer
def binary_code_to_i(code:, zero_char: '0')
  code.each_char.map { |c| c == zero_char ? 0 : 1 }.join.to_i(2)
end

# Testing ###############################################################

def assert(&assertion)
  raise 'assertion failed' unless assertion.call
end

def assert_equal(a, b)
  raise "#{a} != #{b}" unless a == b
end

# Geometry #############################################################

# An integral two dimensional vector
XY = Struct.new(:x, :y) do
  def +(other)
    xy(x + other.x, y + other.y)
  end

  def -(other)
    xy(x - other, y - other.y)
  end

  def rotate(radians:, origin: xy(0, 0))
    c = Math.cos(radians)
    s = Math.sin(radians)

    translated = itself - origin

    xy(translated.x * c - translated.y * s,
       translated.x * s + translated.y * c) + origin
  end
end

def xy(x, y)
  XY.new(x, y)
end

# @param point the center of the neighborhood
# @return the neighborhood of the point (any dimension), including the point itself
def neighborhood_of(point)
  dimension = point.size
  neighborhood_range = 0...3 ** dimension
  neighborhood_range
    .map { |i|
      (0...dimension).reduce([i]) { |a, i|
        quotient = a[-1] / 3
        a[-1] = a[-1] % 3 + point[i] - 1
        a << quotient unless a.size == dimension
        a
      }
    }
end
