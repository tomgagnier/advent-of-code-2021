def count_descending(integers)
  integers[..-2].zip(integers[1..]).filter { |l, r| l < r }.count
end

def process(input_file)
  depths = File.readlines(input_file).map(&:strip).reject(&:empty?).map(&:to_i)

  p count_descending(depths)

  sliding_window_sums = depths[..-3].zip(depths[1..-2], depths[2..]).map(&:sum)
  p count_descending(sliding_window_sums)
end

process('test.txt')
process('input.txt')
