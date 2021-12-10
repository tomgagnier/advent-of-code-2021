def counts_by_position(codes)
  codes.reduce(Hash.new { |h, k| h[k] = 0 }) do |counts, code|
    code.split('').each_with_index { |c, i| counts[i] += 1 if c == '1' }
    counts
  end
end

def rate(codes, use_zero)
  (0...codes[0].size).reduce('') { |s, i| s + (use_zero.call(i) ? '0' : '1') }.to_i(2)
end

def part_1(codes)
  counts = counts_by_position(codes)
  gamma = rate(codes, lambda { |i| 2 * counts[i] < codes.size })
  epsilon = rate(codes, lambda { |i| 2 * counts[i] >= codes.size })
  gamma * epsilon
end

def find_code(codes, select, i = 0)
  return codes[0].to_i(2) if codes.size == 1
  partition = codes.partition { |code| code[i] == '0' }
  find_code(select.call(partition), select, i + 1)
end

def part_2(codes)
  o2_generator = find_code(codes, lambda { |p| p[1].size >= p[0].size ? p[1] : p[0] })
  co2_scrubber = find_code(codes, lambda { |p| p[0].size <= p[1].size ? p[0] : p[1] })
  o2_generator * co2_scrubber
end

def process(input_file)
  codes = File.readlines(input_file).map(&:strip).reject(&:empty?)
  puts "#{input_file}: #{part_1(codes)} #{part_2(codes)}"
end

%w(test.txt input.txt).each { |f| process(f) }
