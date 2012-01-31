require 'set'

class Welder::Dictionary
  def initialize(words)
    @words = Set.new(words)
  end

  def include?(word)
    @words.include?(word)
  end
end