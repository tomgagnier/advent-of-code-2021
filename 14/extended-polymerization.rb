def bottomless_hash(v = 0)
  Hash.new { |h, k| h[k] = 0 }
end

def next_step(rules, char_counts, pair_counts, steps)
  return char_counts if steps == 0
  new_pair_counts = bottomless_hash
  pair_counts.each do |pair, count|
    char = rules[pair]
    char_counts[char] += count
    new_pair_counts[pair[0] + char] += count
    new_pair_counts[char + pair[1]] += count
  end
  next_step(rules, char_counts, new_pair_counts, steps - 1)
end

def process(count, input)
  polymer, rules = File.readlines(input).map(&:strip).chunk { |l| l.empty? }.filter { |b, _| !b }.map { |_, a| a }

  polymer = polymer.join.chars
  char_counts = polymer.reduce(bottomless_hash) { |h, c| h[c] += 1; h }
  pair_counts = polymer[0..-2].zip(polymer[1..]).map(&:join).reduce(bottomless_hash) { |h, pair| h[pair] += 1; h }

  rules = rules.map { |l| l.split(' -> ') }.to_h

  next_step(rules, char_counts, pair_counts, count)

  puts "#{input} #{count} #{char_counts.values.max - char_counts.values.min}"
end

[10, 40].each { |count| %w(test1.txt input.txt).each { |input| process(count, input) } }
