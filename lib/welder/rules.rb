module Welder
  class Rules
    KNOWN_RULES = [
      :cascade_bonus,
      :multiple_word_bonus,
      :hot_tile_bonus,
      :broken_tile_bonus
    ]
    attr_accessor *KNOWN_RULES
    
    # See http://weldergame.com/rules/
    def self.defaults
      {
        :cascade_bonus => 5,
        :multiple_word_bonus => 15,
        :hot_tile_bonus => 10,
        :broken_tile_bonus => 20
      }
    end
    
    def initialize(rules={})
      rules = rules.merge(self.class.defaults)
      rules.each do |k, v|
        send("#{k}=".to_sym, v) if KNOWN_RULES.include?(k)
      end
    end
  end
end