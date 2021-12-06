def census(input, day)
  counts = File.readlines(input).map { |l| l.split(/,/).map(&:to_i) }.flatten
               .reduce(Hash.new { |h, k| h[k] = 0 }) { |counts, time| counts[time] += 1; counts }
  day.times do
    births = counts[0]
    (0..7).each { |i| counts[i] = counts[i + 1] }
    counts[6] += births
    counts[8] = births
  end
  puts "#{input}: population at day #{day}: #{counts.values.sum}"
end

%w(test.txt input.txt).each { |f| puts; [18, 80, 256].each { |d| census(f, d) } }
