def count_descending(integers)
  integers[..-2].zip(integers[1..]).filter { |l, r| l < r }.count
end

def process(input_file)
  depths = File.readlines(input_file).map(&:strip).reject(&:empty?).map(&:to_i)
  sliding_window_sums = depths[..-3].zip(depths[1..-2], depths[2..]).map(&:sum)

  puts "#{input_file} #{count_descending(depths)} #{count_descending(sliding_window_sums)}"
end

%w(test.txt input.txt).each { |f| process(f) }
