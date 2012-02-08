require 'spec_helper'

describe Welder::WeightedArray do
  describe "#initialize" do
    it "throws an error when array does not contain value-weight pairs" do
      items = [[:a, 10], [:b, 20], [:c, 30]]
      invalid_items = [:a, :b, :c]
      lambda { Welder::WeightedArray.new(items) }.should_not raise_error(ArgumentError)
      lambda { Welder::WeightedArray.new(invalid_items) }.should raise_error(ArgumentError)
    end
  end

  describe "#items" do
    it "returns an array of items with their weights and normalized weights" do
      initial_items = [[:a, 10], [:b, 20], [:c, 30]]
      weighted_array = Welder::WeightedArray.new(initial_items)
      weighted_items = weighted_array.items
      weighted_items.size.should == initial_items.size
      weighted_items.each_with_index do |item, index|
        item[:weight].should == initial_items[index][1]
      end
    end
  end

  describe "#normalize" do
    it "assigns a normalized weight to each item" do
      initial_items = [[:a, 10], [:b, 20], [:c, 30]]
      weighted_array = Welder::WeightedArray.new(initial_items)
      weighted_array.normalize
      weighted_items = weighted_array.items
      weighted_items[0][:normalized_weight].should == 10.to_f / 60
      weighted_items[1][:normalized_weight].should == 20.to_f / 60
      weighted_items[2][:normalized_weight].should == 30.to_f / 60
    end
  end

  describe "#sample" do
    it "returns an item based on the weight" do
      srand(0)
      initial_items = [[:a, 1], [:b, 9]]
      weighted_array = Welder::WeightedArray.new(initial_items)

      picks = []
      100.times do
        picks << weighted_array.sample
      end

      a_count = picks.select{|p| p == :a}.length
      b_count = picks.select{|p| p == :b}.length
      a_count.should be_within(5).of(10)
      b_count.should be_within(5).of(90)
    end
  end
end