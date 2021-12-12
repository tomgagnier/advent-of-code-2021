def neighbors_of(i0, j0, max_i, max_j)
  [[-1, 0], [1, 0], [0, 1], [0, -1], [-1, 1], [-1, -1], [1, 1], [1, -1]]
    .map { |di, dj| [i0 + di, j0 + dj] }
    .filter { |i, j| i.between?(0, max_i) && j.between?(0, max_j) }
end

def positions(max_i, max_j)
  (0..max_i).map { |i| (0..max_j).map { |j| [i, j] } }.flatten(1)
end

def neighbors(positions, max_i, max_j)
  positions.map { |position| neighbors_of(*position, max_i, max_j) }
end

POSITIONS = positions(10, 10)
NEIGHBORS = neighbors(POSITIONS, 10, 10)

def flash(powers, flashed = [])
  flashes = powers.map.with_index { |p, i| }
  return flashed.size if flashes.empty?
  (flashes.map { |i, j| neighbors_of(i, j) }.flatten(1) - flashed).each { |i, j| powers[j][i] += 1 }
  flashes.each { |i, j| powers[j][i] = 0 }
  flash(powers, flashed + flashes)
end

def next_step(powers)
  flash(powers.map { |p| p + 1 })
end

def part_1(powers)
  100.times.map { next_step(powers) }.sum
end

def part_2(powers)
  (1..Float::INFINITY).lazy.find { next_step(powers) == 100 }
end

def process(input)
  powers = File.readlines(input).map(&:strip).reject(&:empty?).map { |l| l.chars.map(&:to_i) }.flatten
  p powers
  p POSITIONS
  p NEIGHBORS

  p next_step(powers)
end

# %w(test.txt input.txt).each { |f| process(f) }
%w(test.txt).each { |f| process(f) }
