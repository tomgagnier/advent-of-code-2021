def range(n0, n1)
  n0 < n1 ? n0.upto(n1) : n0.downto(n1)
end

def to_points(line)
  x0, y0, x1, y1 = line.flatten
  if x0 == x1
    range(y0, y1).map { |y| [x0, y] }
  elsif y0 == y1
    range(x0, x1).map { |x| [x, y0] }
  else
    []
  end
end

def to_points2(line)
  x0, y0, x1, y1 = line.flatten
  if x0 == x1
    range(y0, y1).map { |y| [x0, y] }
  elsif y0 == y1
    range(x0, x1).map { |x| [x, y0] }
  else
    range(x0, x1).zip(range(y0, y1))
  end
end

def part_1(lines)
  lines.map { |l| to_points(l) }.flatten(1)
       .reduce(Hash.new { |h, k| h[k] = 0 }) { |h, p| h[p] += 1; h }
    .values.filter { |n| n > 1 }.count
end

def part_2(lines)
  lines.map { |l| to_points2(l) }.flatten(1)
       .reduce(Hash.new { |h, k| h[k] = 0 }) { |h, p| h[p] += 1; h }
    .values.filter { |n| n > 1 }.count
end

def process(input_file)
  lines = File.readlines(input_file).map(&:strip).reject(&:empty?)
              .map { |l| /(?<x1>\d+),(?<y1>\d+) -> (?<x2>\d+),(?<y2>\d+)/.match(l) }
              .map { |m| [[m[:x1].to_i, m[:y1].to_i], [m[:x2].to_i, m[:y2].to_i]] }
  puts "#{input_file}: \n\t1) #{part_1(lines)} \n\t2) #{part_2(lines)}"
end

%w(test.txt input.txt).each { |f| process(f) }
