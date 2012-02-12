require 'spec_helper'

describe Welder::Rules do
  describe "#initialize" do
    it "sets provided values that appear in KNOWN_RULES" do
      settings = { :cascade_bonus => 5 }
      rules = Welder::Rules.new(settings)
      rules.cascade_bonus.should == settings[:cascade_bonus]
    end
    
    it "ignores provided values that don't appear in KNOWN_RULES" do
      settings = { :love_triangle_bonus => 50 }
      rules = Welder::Rules.new(settings)
      rules.respond_to?(:love_triangle_bonus).should be_false
    end
  end
end