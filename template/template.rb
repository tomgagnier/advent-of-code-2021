def part_1(lines)
  lines
end

def part_2(lines)
  'incomplete'
end

def process(input)
  lines = File.readlines(input).map(&:strip).reject(&:empty?)
  words = lines.map(&:split).flatten
  integers = lines.map { |l| l.split(',').map(&:to_i) }.flatten
  regex = /...(?<name_1>pattern_1).../
  matches = lines.map{|l| regex.match(l)}.map{|m| m[:pattern_1]}
  paragraphs = File.readlines(input).map(&:strip).chunk { |l| l.empty? }.filter { |b, _| !b }.map { |_, a| a }.to_a

  puts "#{input}: \n\t1) #{part_1(lines)} \n\t2) #{part_2(lines)}"
end

process('test.txt')

#%w(test.txt input.txt).each { |f| process(f) }
