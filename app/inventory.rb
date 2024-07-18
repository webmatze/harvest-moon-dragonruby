# inventory.rb

class Inventory
  attr_accessor :items, :money

  def initialize
    @items = {
      crops: Crops.new,
      animals: Animals.new,
      tools: Tools.new
    }
    @money = 100  # Starting money for the player
  end

  def add_item(item_type, item_class)
    item = item_class.new
    @items[item_type] << item
  end

  def remove_item(item_type, item_class)
    if has_item?(item_type, item_class)
      @items[item_type].delete(item_class)
    else
      puts "Item #{item_name} not found in inventory."
    end
  end

  def has_item?(item_type, item_class)
    @items[item_type].any?(item_class)
  end

  def render(args)
    x = 720
    y = 610
    args.outputs.labels << { x: x, y: y, text: "Inventory:", size_enum: 2, font: UI::FONT }.merge(UI::WHITE_COLOR)
    y -= 60
    x += 30

    @items.each do |item_type, item_list|
      item_list.group_by_class.each do |type, type_items|
        args.outputs.labels << { x: x, y: y, text: "- #{type.name.capitalize}: #{type_items.size}", size_enum: 1, font: UI::FONT }.merge(UI::WHITE_COLOR)
        y -= 30
      end
    end
  end
end
