def range(n0, n1)
  n0 < n1 ? n0.upto(n1) : n0.downto(n1)
end

def vertical(x0, y0, x1, y1)
  x0 == x1 ? range(y0, y1).map { |y| [x0, y] } : []
end

def horizontal(x0, y0, x1, y1)
  y0 == y1 ? range(x0, x1).map { |x| [x, y0] } : []
end

def diagonal(x0, y0, x1, y1)
  (x1 - x0).abs == (y1- y0).abs ? range(x0, x1).zip(range(y0, y1)) : []
end

def count(lines)
  lines.map{|l| yield(l) }.flatten(1)
       .reduce(Hash.new { |h, k| h[k] = 0 }) { |h, p| h[p] += 1; h }
    .values.filter { |n| n > 1 }.count
end

def part_1(lines)
  count(lines) {|l| vertical(*l) + horizontal(*l)}
end

def part_2(lines)
  count(lines) {|l| vertical(*l) + horizontal(*l) + diagonal(*l)}
end

def process(input_file)
  lines = File.readlines(input_file).map(&:strip).reject(&:empty?)
              .map { |l| /(?<x0>\d+),(?<y0>\d+) -> (?<x1>\d+),(?<y1>\d+)/.match(l) }
              .map { |m| [m[:x0].to_i, m[:y0].to_i, m[:x1].to_i, m[:y1].to_i] }
  puts "#{input_file}: \n\t1) #{part_1(lines)} \n\t2) #{part_2(lines)}"
end

%w(test.txt input.txt).each { |f| process(f) }
