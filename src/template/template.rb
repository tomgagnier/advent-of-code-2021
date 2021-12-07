def part_1(lines)
  lines
end

def part_2(lines)
  'incomplete'
end

def process(input)
  lines = File.readlines(input).map(&:strip).reject(&:empty?)
  paragraphs = File.readlines(input).map(&:strip).chunk { |l| l.empty? }.filter { |b, _| !b }.map { |_, a| a }.to_a

  puts "#{input}: \n\t1) #{part_1(lines)} \n\t2) #{part_2(lines)}"
end

process('test.txt')

#%w(test.txt input.txt).each { |f| process(f) }
