require_relative '../aoc.rb'

def part_1(lines)
  'incomplete'
end

def part_2(lines)
  'incomplete'
end

def process(input_file)
  lines = File.readlines(input_file).map(&:strip).reject(&:empty?)

  puts "#{input_file}: 1) #{part_1(lines)} 2) #{part_2(lines)}"
end

process('test.txt')

#%w(test.txt input.txt).each { |f| process(f) }

