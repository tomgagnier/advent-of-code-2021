def winner?(card)
  columns = (0...card.size).map { |i| (0...card.size).map { |j| card[j][i] } }
  (card + columns).find { |v| v.all? { |n| n == -1 } }
end

def rank_winners(draws, cards, ranked_winners = [])
  return ranked_winners if cards.empty?
  winners, losers = cards.map { |card| card.map { |row| row.map { |number| number == draws[0] ? -1 : number } } }
                         .partition { |card| winner?(card) }
  rank_winners(draws[1..], losers, ranked_winners + winners.map { |card| [draws[0], card] })
end

def score(ranked_winners, index)
  draw, winner = ranked_winners[index]
  draw * winner.flatten.filter { |n| n > 0 }.sum
end

def process(input_file)
  paragraphs = File.readlines(input_file)
                   .map { |l| l.strip.split(/[ ,]+/).map(&:to_i) }
                   .chunk { |line| line.empty? }
                   .filter { |b, _| !b }.map { |_, a| a }
                   .to_a
  draws = paragraphs[0].flatten
  cards = paragraphs[1..]
  winners = rank_winners(draws, cards)
  puts "#{input_file}: 1) #{score(winners, 0)} 2) #{score(winners, -1)}"
end

%w(test.txt input.txt).each { |f| process(f) }
