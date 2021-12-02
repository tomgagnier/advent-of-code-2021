require '../aoc.rb'

def count_descending(integers)
  integers[0..-2].zip(integers[1..-1]).filter { |l, r| l < r }.count
end

depths = read_lines('test.txt').map(&:to_i)

p count_descending(depths)

p count_descending(depths[..-3].zip(depths[1..-2], depths[2..]).map(&:sum))
