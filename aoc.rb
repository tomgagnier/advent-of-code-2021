# Shared Advent of Code Utilities
# frozen_string_literal: true

require 'set'

# IO ##################################################################

def read_lines(input)
  File.readlines(input).map(&:strip).reject(&:empty?)
end

# Convert an input file to an array of paragraphs
def read_paragraphs(input)
  File.readlines(input).map(&:strip).chunk { |line| line.empty? }.filter { |b, _| !b }.map { |_, a| a }.to_a
end

# Convert a text matrix to a 2d matrix of [i][j]
def read_2d_matrix(input)
  File.readlines(input).map(&:strip).reject(&:empty?).map(&:chars).transpose
end

# Binary ###############################################################

# Translate a string representation of a bitfield to an integer
def binary_code_to_i(code, zero_char = '0')
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
#

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

def paths(connections, is_ended, is_valid, candidates, paths)
  return paths if candidates.empty?
  ended, candidates = candidates.partition { |path| is_ended.call(path) }
  paths(connections, is_ended, is_valid,
        candidates.select { |path| is_valid.call(path) }
                  .map { |path| connections[path[-1]].map { |node| path + [node] } }
                  .flatten(1),
        paths + ended)
end

# @connections list of each node and its directed connections
# @is_ended    lambda predicate of path, selecting paths for result
# @is_valid    lambda predicate of path, selecting paths for next iteration
# @start       starting node
# @return      array of node arrays representing paths
def walk(connections, is_ended, is_valid, start)
  paths(connections, is_ended, is_valid, [[start]], [])
end

# @param point the center of the neighborhood
# @return the neighborhood of the point (any dimension), including the point itself
def neighborhood_of(point)
  neighborhood_size = 3 ** point.size
  (0...neighborhood_size).map do |index|
    (0...point.size).reduce([index]) do |neighbor, n|
      div3 = neighbor[-1] / 3
      mod3 = neighbor[-1] % 3
      neighbor[-1] = mod3 + point[n] - 1
      neighbor << div3 unless neighbor.size == point.size
      neighbor
    end
  end
end

def neighborhood_of2(point)
  neighborhood_size = 3 ** point.size
  (0...neighborhood_size).map do |index|
    div3 = index / 3 - 1
    mod3 = index % 3 - 1
    puts "#{div3} #{mod3}"
    (0...point.size).map do |n|

    end
  end
end

neighborhood = neighborhood_of2([1, 1])
p neighborhood, neighborhood.count, neighborhood.uniq.count

def bottomless_hash(v = 0)
  Hash.new { |h, k| h[k] = 0 }
end

