def paths(connections, constraint, paths = [], candidates = [['start']])
  return paths if candidates.empty?
  candidates, ended = candidates.partition { |path| path[-1] != 'end' }
  paths(connections, constraint, paths + ended,
        candidates.select { |path| constraint.call(path) }
                  .map { |path| connections[path[-1]].map { |node| path + [node] } }
                  .flatten(1))
end

def duplicate_small_cave_count(path)
  path.reject { |n| n == n.upcase }.tally.values.map { |v| v - 1 }.sum
end

def process(input)
  connections = File.readlines(input).map(&:strip).reject(&:empty?).map { |l| l.split('-') }
                    .map { |connection| [connection, connection.reverse] }.flatten(1)
                    .reject { |l, r| l == 'end' || r == 'start' }
                    .reduce(Hash.new { |h, k| h[k] = [] }) { |h, p| h[p[0]] << p[1]; h }
  puts "#{input}:"
  puts "\t1) #{paths(connections, lambda { |path| duplicate_small_cave_count(path) < 1 }).size}"
  puts "\t2) #{paths(connections, lambda { |path| duplicate_small_cave_count(path) < 2 }).size}"
end

%w(test1.txt test2.txt test3.txt input.txt).each { |file| process(file) }
