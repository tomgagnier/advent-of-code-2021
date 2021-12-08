def to_digits(segments)
  cf = segments.find { |segment| segment.size == 2 }
  bcdf = segments.find { |segment| segment.size == 4 }
  acf = segments.find { |segment| segment.size == 3 }
  abcdefg = segments.find { |segment| segment.size == 7 }
  adg = segments.filter { |segment| segment.size == 5 }.reduce(:&)
  abfg = segments.filter { |segment| segment.size == 6 }.reduce(:&)

  a = acf - cf
  d = bcdf - cf & adg - a
  b = bcdf - cf - d
  g = adg - a - d
  f = cf & abfg - a
  c = cf - f
  e = abcdefg - a - b - c - d - f - g

  [[a, b, c, e, f, g],
   [c, f],
   [a, c, d, e, g],
   [a, c, d, f, g],
   [b, c, d, f],
   [a, b, d, f, g],
   [a, b, d, e, f, g],
   [a, c, f],
   [a, b, c, d, e, f, g],
   [a, b, c, d, f, g]].map { |digit| digit.sort.join }
end

def to_code(segments, signals)
  digits = to_digits(segments)
  signals.map { |signal| (0..9).find { |n| signal == digits[n] } }.join.to_i
end

def process(file)
  seg_sig = File.readlines(file).map(&:strip).reject(&:empty?)
                .map { |line| line.split(' | ').map { |pair| pair.split.map { |word| word.chars.sort.join } } }

  part_1 = seg_sig.map { |_, signal| signal.filter { |digit| [2, 3, 4, 7].include?(digit.size) } }.flatten.size
  part_2 = seg_sig.map { |segment, signal| to_code(segment.map(&:chars), signal) }.sum

  puts "#{file}\n\t1) #{part_1}\n\t2) #{part_2}"
end

%w(test.txt input.txt).each { |file| process(file) }
