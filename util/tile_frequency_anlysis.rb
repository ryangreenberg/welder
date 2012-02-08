# This is a small script to determine the weightings used to generate random
# tiles to populate the game board. It outputs the observed frequency of
# letters from actual game boards.

# The output is one line per board in the input file, with two columns per
# letter. The first column is the frequency in the total population summed from
# board 1 to i (e.g. row 1 is board 1, row 2 is board 1 + 2, row 3 is board 1 +
# 2 + 3). The second column is the percent of change between the current
# frequency and the frequency of the last row. This can be used to determine
# when the frequency has stabilized across the input sample.

class Float
  def round_to(digits=0)
    return self unless self.finite?
    (self * 10**digits).round.to_f / 10**digits
  end
end

# Read game boards from file
file_path = ARGV.last
src = File.read(file_path)
boards = src.split("\n\n").map{|board| board.split("\n").map{|row| row.split("")}}
headers = ("a".."z").to_a + ["*"]

chars_by_occurances = headers.inject({}) {|hsh, k| hsh[k] = 0; hsh}
chars_by_percent_of_population = headers.inject({}) {|hsh, k| hsh[k] = 0; hsh}

stats = []

boards.each do |board|
  # Add the counts of characters on this board
  board.flatten.map{|c| c.downcase}.reject{|c| c=='*'}.each do |char|
    chars_by_occurances[char] += 1
  end

  total_chars = chars_by_occurances.inject(0) {|sum, (char, count)| sum += count}

  stats << chars_by_occurances.keys.sort.map do |key|
    char, count = key, chars_by_occurances[key]
    char_percent_of_populuation = (count.to_f / total_chars * 100).round_to(2)
    prev_char_percent_of_population = chars_by_percent_of_population[char]

    abs_change = char_percent_of_populuation - prev_char_percent_of_population
    percent_change = (abs_change.to_f / prev_char_percent_of_population * 100).round_to(2)
    chars_by_percent_of_population[char] = char_percent_of_populuation

    {
      :char => char,
      :percent_of_population => char_percent_of_populuation,
      :abs_change => abs_change,
      :percent_change => percent_change
    }
  end
end

# Output
puts headers.sort.join("\t\t")
output = stats.map do |board|
  board.map do |cell|
    [ cell[:percent_of_population], cell[:abs_change] ]
  end.flatten.join("\t")
end.join("\n")
puts output