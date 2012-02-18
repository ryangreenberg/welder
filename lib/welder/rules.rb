module Welder
  class Rules
    KNOWN_RULES = [
      :min_word_length,
      :starting_swaps,
      :cascade_bonus,
      :multiple_word_bonus,
      :hot_tile_bonus,
      :broken_tile_bonus
    ]
    attr_accessor *KNOWN_RULES

    # See http://weldergame.com/rules/
    def self.defaults
      {
        :min_word_length => 4,
        :starting_swaps => {
          1 => 25
        },
        :cascade_bonus => 5,
        :multiple_word_bonus => 15,
        :hot_tile_bonus => 10,
        :broken_tile_bonus => 20
      }
    end

    def initialize(rules={})
      rules = self.class.defaults.merge(rules)
      rules.each do |k, v|
        send("#{k}=".to_sym, v) if KNOWN_RULES.include?(k)
      end
    end

    def starting_swaps_for_level(level)
      starting_swaps[level]
    end
  end
end