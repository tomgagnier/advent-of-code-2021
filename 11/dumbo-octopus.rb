OFFSETS = [[-1, 0], [1, 0], [0, 1], [0, -1], [-1, 1], [-1, -1], [1, 1], [1, -1]]
COORDINATES = (0..9).map { |j| (0..9).map { |i| [i, j] } }.flatten(1)

def neighbors(i0, j0)
  OFFSETS.map { |di, dj| [i0 + di, j0 + dj] }.filter { |i, j| i.between?(0, 9) && j.between?(0, 9) }
end

def flash(matrix, flashed = [])
  flashes = (COORDINATES - flashed).filter { |i, j| matrix[j][i] > 9 }
  return flashed.size if flashes.empty?
  (flashes.map { |i, j| neighbors(i, j) }.flatten(1) - flashed).each { |i, j| matrix[j][i] += 1 }
  flashes.each { |i, j| matrix[j][i] = 0 }
  flash(matrix, flashed + flashes)
end

def next_step(matrix)
  flash(matrix.map! { |r| r.each.map { |c| c + 1 } })
end

def part_1(matrix)
  100.times.map { next_step(matrix) }.sum
end

def part_2(matrix)
  (1..Float::INFINITY).lazy.find { next_step(matrix) == 100 }
end

def read_matrix(input)
  File.readlines(input).map(&:strip).reject(&:empty?).map { |l| l.chars.map(&:to_i) }
end

def process(input)
  puts "#{input}: \n\t1) #{part_1(read_matrix(input))} \n\t2) #{part_2(read_matrix(input))}"
end

%w(test.txt input.txt).each { |f| process(f) }
