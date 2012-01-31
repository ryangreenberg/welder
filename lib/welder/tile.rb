class Welder::Tile
  LETTER_VALUES = {"aeiou" => 1, "dlnrst" => 2, "bcfghkmpwxy" => 4, "jqvz" => 8}.inject({}) do |hsh, (letters, value)|
    letters.split("").each {|letter| hsh[letter] = value}
    hsh
  end

  def initialize(letter)
    @letter = letter
  end

  def value
    LETTER_VALUES[@letter]
  end
end