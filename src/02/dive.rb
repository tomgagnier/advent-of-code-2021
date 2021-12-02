def part_1(moves)
  position = moves.reduce({ x: 0, z: 0 }) do |position, (direction, distance)|
    case direction
    when :up
      position[:z] -= distance
    when :down
      position[:z] += distance
    else
      position[:x] += distance
    end
    position
  end
  position[:x] * position[:z]
end

def part_2(moves)
  position = moves.reduce({ x: 0, z: 0, aim: 0 }) do |position, (direction, distance)|
    case direction
    when :up;
      position[:aim] -= distance
    when :down;
      position[:aim] += distance
    else
      position[:x] += distance
      position[:z] += position[:aim] * distance
    end
    position
  end
  position[:x] * position[:z]
end

def process(input_file)
  moves = File.readlines(input_file).reject(&:empty?).map(&:split)
              .map { |direction, distance| [direction.to_sym, distance.to_i] }
  puts "#{input_file}: #{part_1(moves)}, #{part_2(moves)}"
end

%w(test.txt input.txt).each { |f| process(f) }
