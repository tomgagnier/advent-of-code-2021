def process(input)
  positions = File.readlines(input).map(&:strip).reject(&:empty?).map { |l| l.split(',').map(&:to_i) }.flatten
  part_1 = (positions.min..positions.max).map { |candidate| positions.map { |p| (p - candidate).abs }.sum }.min
  part_2 = (positions.min..positions.max).map { |candidate| positions.map { |p| (1..(p - candidate).abs).sum }.sum }.min
  puts "#{input}: \n\t1) #{part_1} \n\t2) #{part_2}"
end

%w(test.txt input.txt).each { |input| process(input) }
