# inventory.rb

class Inventory
  attr_accessor :items, :money

  def initialize
    @items = {
      crops: {},
      animals: {},
      tools: {}
    }
    @money = 100  # Starting money for the player
  end

  def add_item(item_type, item_name, item = {})
    if @items[item_type].key?(item_name)
      @items[item_type][item_name][:quantity] += 1
    else
      @items[item_type][item_name] = item.merge({ quantity: 1 })
    end
  end

  def remove_item(item_type, item_name)
    if @items[item_type].key?(item_name)
      @items[item_type][item_name][:quantity] -= 1
      if @items[item_type][item_name][:quantity] <= 0
        @items[item_type].delete(item_name)
      end
    else
      puts "Item #{item_name} not found in inventory."
    end
  end

  def has_item?(item_type, item_name)
    @items[item_type].key?(item_name) && @items[item_type][item_name][:quantity] > 0
  end

  def render(args)
    x = 720
    y = 610
    args.outputs.labels << { x: x, y: y, text: "Inventory:", size_enum: 2, font: UI::FONT }.merge(UI::WHITE_COLOR)
    y -= 60
    x += 30

    @items.each do |item_type, values|
      values.each do |item_name, item|
        args.outputs.labels << { x: x, y: y, text: "- #{item_name.capitalize}: #{item[:quantity]}", size_enum: 1, font: UI::FONT }.merge(UI::WHITE_COLOR)
        y -= 30
      end
    end
  end
end
