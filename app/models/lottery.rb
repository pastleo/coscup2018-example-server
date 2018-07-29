# frozen_string_literal: true

class Lottery
  def initialize(items)
    @items = items
  end

  def draw
    return unless @items.any?
    weights = @items.map(&:weight)
    n = rand(1..weights.sum)
    weights.each_with_index do |weight, i|
      n -= weight
      return @items[i] if n <= 0
    end
  end
end
