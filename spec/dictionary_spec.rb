require 'spec_helper'

describe Welder::Dictionary do
  before do
    @words = ['apple', 'banana', 'cumquat']
  end

  describe "#initialize" do
    it "excludes words longer than the max_length" do
      short_word = 'kiwi'
      long_word = 'apple'
      words = [ short_word, long_word ]
      dictionary = Welder::Dictionary.new(words, 4)
      dictionary.should include(short_word)
      dictionary.should_not include(long_word)
    end
  end

  describe "#include?" do
    it "returns true if the dictionary was initialized with the given word" do
      dictionary = Welder::Dictionary.new(@words)
      dictionary.include?(@words.first).should be_true
    end

    it "returns false if the dictionary was not initialized with the given word" do
      dictionary = Welder::Dictionary.new(@words)
      dictionary.include?('durian').should be_false
    end
  end
end
