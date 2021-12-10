HORIZONTAL = [[-1, 0], [1, 0]]
VERTICAL = [[0, 1], [0, -1]]
DIAGONAL = [[-1, 1], [-1, -1], [1, 1], [1, -1]]

def neighbors(offsets, matrix, i0, j0)
  offsets.map { |di, dj| [i0 + di, j0 + dj] }
         .filter { |i, j| i.between?(0, matrix.size - 1) && j.between?(0, matrix[0].size - 1) }
end

def to_basin(matrix, todo, visited = [], basin = [])
  return basin.sort.uniq if todo.empty?
  i, j = todo.pop
  visited << [i, j]
  if matrix[i][j] != 9
    basin << [i, j]
    todo += neighbors(HORIZONTAL + VERTICAL, matrix, i, j).reject { |p| visited.include?(p) }
  end
  to_basin(matrix, todo, visited, basin)
end

def neighboring_heights(i, j, matrix)
  neighbors(HORIZONTAL + VERTICAL + DIAGONAL, matrix, i, j).map { |i1, j1| matrix[i1][j1] }
end

def process(input)
  matrix = File.readlines(input).map(&:strip).reject(&:empty?).map { |l| l.chars.map(&:to_i) }
  indexes = (0...matrix.size).map { |i| (0...matrix[0].size).map { |j| [i, j] } }.flatten(1)
  low_points = indexes.filter { |i, j| matrix[i][j] < neighboring_heights(i, j, matrix).min }

  part_1 = low_points.map { |i, j| matrix[i][j] + 1 }.sum

  part_2 = low_points.map { |low_point| to_basin(matrix, [low_point]) }
                     .map(&:size).sort.reverse.take(3).reduce(&:*)

  puts "#{input}\n\t1) #{part_1}\n\t2) #{part_2}"
end

%w(test.txt input.txt).each { |f| process(f) }
