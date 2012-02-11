require 'set'

class Welder::Dictionary
  def initialize(words, max_length = nil)
    words.reject! {|w| w.size > max_length } if max_length
    @words = Set.new(words)
  end

  def include?(word)
    @words.include?(word)
  end
end
