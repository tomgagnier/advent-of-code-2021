def fold(dots, axis, value)
  if axis == :x
    dots.map { |d| d[0] < value ? d : [2 * value - d[0], d[1]] }
  else
    dots.map { |d| d[1] < value ? d : [d[0], 2 * value - d[1]] }
  end.uniq
end

def fold_all(dots, folds)
  return dots if folds.empty?
  dots = fold(dots, *folds.shift)
  fold_all(dots, folds)
end

def to_lines(dots)
  i_max = dots.map { |x, _| x }.max
  j_max = dots.map { |_, y| y }.max
  0.upto(j_max).map { |j| 0.upto(i_max).map { |i| dots.include?([i, j]) ? '#' : '.' }.join }
end

def process(input)
  dots, folds = File.readlines(input).map(&:strip).chunk { |l| l.empty? }.filter { |b, _| !b }.map { |_, a| a }.to_a
  dots.map! { |dot| dot.split(',').map(&:to_i) }

  folds.map! { |f| /fold along (?<axis>[xy])=(?<value>\d+)/.match(f) }
       .map! { |m| [m[:axis].to_sym, m[:value].to_i] }

  puts input
  puts "1) #{fold(dots, *folds[0]).count}"
  puts "2)", to_lines(fold_all(dots, folds))
end

%w(test.txt input.txt).each { |f| process(f) }
