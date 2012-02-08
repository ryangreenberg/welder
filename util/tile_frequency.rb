# This is a small script to determine the weightings used to generate random
# tiles to populate the game board. It outputs the observed frequency of
# letters from actual game boards.

require 'yaml'

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
headers = ("a".."z").to_a

chars_by_occurances = headers.inject({}) {|hsh, k| hsh[k] = 0; hsh}

boards.flatten.map{|c| c.downcase}.reject{|c| c=='*'}.each do |char|
  chars_by_occurances[char] += 1
end

total_chars = chars_by_occurances.inject(0) {|sum, (char, count)| sum += count}

weights = chars_by_occurances.inject({}) do |hsh, (char, count)|
  hsh[char] = (count.to_f / total_chars).round_to(3)
  hsh
end

puts YAML.dump(weights)