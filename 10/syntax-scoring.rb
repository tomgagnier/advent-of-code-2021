def category_of(line, position = 0, unmatched = [])
  if line.size == position
    return [:incomplete, unmatched]
  end
  if '([{<'.include?(line[position])
    unmatched << line[position]
  elsif %w(() [] {} <>).include?("#{unmatched[-1]}#{line[position]}")
    unmatched.pop
  else
    return [:corrupted, line[position]]
  end
  category_of(line, position + 1, unmatched)
end

def process(input)
  corrupted, incomplete = File.readlines(input).map(&:strip).reject(&:empty?).map(&:chars)
                              .map { |line| category_of(line) }
                              .partition { |status, _| status == :corrupted }

  syntax_error_scores = corrupted.map { |_, char| { ')' => 3, ']' => 57, '}' => 1197, '>' => 25137 }[char] || 0 }

  completion_scores = incomplete.map { |_, unmatched| unmatched.reverse }
                                .map { |u| u.reduce(0) { |s, c| 5 * s + { '(' => 1, '[' => 2, '{' => 3, '<' => 4 }[c] } }
                                .sort

  puts "#{input}: \n\t1) #{syntax_error_scores.sum} \n\t2) #{completion_scores[completion_scores.size / 2]}"
end

%w(test.txt input.txt).each { |file| process(file) }
