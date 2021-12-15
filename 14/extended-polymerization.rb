def bottomless_hash(v = 0)
  Hash.new { |h, k| h[k] = 0 }
end

def next_step(rules, pairs, char_counts, pair_counts)
  new_pair_counts = bottomless_hash
  pair_counts.each do |pair, count|
    char = rules[pair]
    char_counts[char] += count
    pairs[pair].each { |p| new_pair_counts[p] += count }
  end
  new_pair_counts
end

def process(count, input)
  polymer, rules = File.readlines(input).map(&:strip).chunk { |l| l.empty? }.filter { |b, _| !b }.map { |_, a| a }.to_a

  polymer = polymer.join
  rules = rules.map { |l| l.split(' -> ') }
  pairs = rules.map { |i, o| [i, [i[0] + o, o + i[1]]] }.to_h
  rules = rules.to_h

  char_counts = polymer.chars.reduce(bottomless_hash) { |h, c| h[c] += 1; h }
  pair_counts = polymer.chars[0..-2].zip(polymer.chars[1..]).map(&:join)
                       .reduce(bottomless_hash) { |h, pair| h[pair] += 1; h }
  count.times { pair_counts = next_step(rules, pairs, char_counts, pair_counts) }
  puts "#{input} #{count} #{char_counts.values.max - char_counts.values.min}"
end

[10, 40].each { |count| %w(test1.txt input.txt).each { |input| process(count, input) } }
