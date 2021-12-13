def paths(connections, is_ended, is_valid, paths = [], candidates = [['start']])
  return paths if candidates.empty?
  ended, candidates = candidates.partition { |path| is_ended.call(path) }
  paths(connections, is_ended, is_valid, paths + ended,
        candidates.select { |path| is_valid.call(path) }
                  .map { |path| connections[path[-1]].map { |node| path + [node] } }
                  .flatten(1))
end

def duplicate_small_cave_count(path)
  path.reject { |n| n == n.upcase }.tally.values.map { |v| v - 1 }.sum
end

def process(input)
  puts "#{input}:"
  connections = File.readlines(input).map(&:strip).reject(&:empty?).map { |l| l.split('-') }
                    .map { |connection| [connection, connection.reverse] }.flatten(1)
                    .reject { |l, r| l == 'end' || r == 'start' }
                    .reduce(Hash.new { |h, k| h[k] = [] }) { |h, p| h[p[0]] << p[1]; h }
  is_ended = lambda{|path| path[-1] == 'end'}
  puts "\t1) #{paths(connections, is_ended, lambda { |path| duplicate_small_cave_count(path) < 1 }).size}"
  puts "\t2) #{paths(connections, is_ended, lambda { |path| duplicate_small_cave_count(path) < 2 }).size}"
end

%w(test1.txt test2.txt test3.txt input.txt).each { |file| process(file) }
