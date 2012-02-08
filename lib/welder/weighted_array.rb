# This class is based on the blog post at
# http://eli.thegreenplace.net/2010/01/22/weighted-random-generation-in-python/
class Welder::WeightedArray
  attr_reader :items

  def initialize(arr=[])
    @items = []
    arr.each do |item, weight|
      raise ArgumentError, "Expected pair of item, weight" unless weight
      push(item, weight)
    end
    @is_normalized = false
  end

  def push(item, weight)
    @is_normalized = false
    @items.push(item_for(item, weight))
  end

  def normalize
    total_weights = @items.inject(0) {|sum, item| sum += item[:weight]}.to_f
    @items.each do |item|
      item[:normalized_weight] = item[:weight] / total_weights
    end
    @is_normalized = true
  end

  def sample
    normalize unless @is_normalized

    random_value = rand
    items.each do |item|
      random_value -= item[:normalized_weight]
      return item[:value] if random_value < 0
    end

    items.last[:value] if items.size > 0
  end

  private

  def item_for(item, weight)
    {
      :value => item,
      :weight => weight,
      :normalized_weight => nil
    }
  end
end