def duplicate_small_cave_count(path)
  small_caves = path.reject { |n| /^[A-Z]+$/.match?(n) }
  small_caves.size - small_caves.uniq.size
end

def paths(connections, constraint, candidates = [['start']], paths = [])
  return paths if candidates.empty?
  candidates, ended = candidates.partition { |path| path[-1] != 'end' }
  candidates.select! { |path| constraint.call(path) }
  candidates.map! { |path| connections[path[-1]].map { |node| path + [node] } }
  paths(connections, constraint, candidates.flatten(1), paths + ended)
end

def process(input)
  connections = File.readlines(input).map(&:strip).reject(&:empty?).map { |l| l.split('-') }
                    .reduce(Hash.new { |h, k| h[k] = [] }) { |h, c|
                      if c[0] == 'end'
                        h[c[1]] << c[0]
                      elsif c[1] == 'end'
                        h[c[0]] << c[1]
                      elsif c[0] == 'start'
                        h[c[0]] << c[1]
                      elsif c[1] == 'start'
                        h[c[1]] << c[0]
                      else
                        h[c[0]] << c[1]
                        h[c[1]] << c[0]
                      end
                      h }

  part_1 = paths(connections, lambda { |path| duplicate_small_cave_count(path) == 0 }).size
  part_2 = paths(connections, lambda { |path| duplicate_small_cave_count(path) <= 1 }).size

  puts " #{input}: \n\t1) #{part_1}\n\t2) #{part_2}"
end

%w(test1.txt test2.txt test3.txt input.txt).each{|file| process(file)}
