# market.rb

class Market
  attr_accessor :items_for_sale, :player_inventory

  def initialize
    @items_for_sale = {
      crops: {
        wheat: { price: 10, image: 'assets/images/wheat.png' },
        corn: { price: 15, image: 'assets/images/corn.png' }
      },
      animals: {
        cow: { price: 100, image: 'assets/images/cow.png' },
        chicken: { price: 50, image: 'assets/images/chicken.png' }
      },
      tools: {
        hoe: { price: 20, image: 'assets/images/hoe.png' },
        sickle: { price: 25, image: 'assets/images/sickle.png' },
        watering_can: { price: 30, image: 'assets/images/watering_can.png' }
      }
    }
  end

  def buy_item(item_type, item_name, player)
    item = @items_for_sale[item_type][item_name]
    if player.inventory.money >= item[:price]
      player.inventory.money -= item[:price]
      player.inventory.add_item(item_type, item_name, item)
      puts "Bought #{item_name} for #{item[:price]} money."
    else
      puts "Not enough money to buy #{item_name}."
    end
  end

  def sell_item(item_type, item_name, player)
    item = player.inventory.remove_item(item_type, item_name)
    if item
      player.inventory.money += item[:price]
      puts "Sold #{item_name} for #{item[:price]} money."
    else
      puts "You don't have #{item_name} to sell."
    end
  end

  def render(args)
    # Render market UI (this is a placeholder, actual UI rendering will be more complex)
    args.outputs.labels << [10, 700, "Market", 5, 1]
    y = 650
    @items_for_sale.each do |type, items|
      items.each do |name, item|
        args.outputs.labels << [10, y, "#{name.capitalize}: #{item[:price]} money", 2, 1]
        y -= 30
      end
    end
  end
end
