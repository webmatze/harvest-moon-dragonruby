# crops.rb

class Crop
  attr_accessor :type, :growth_stage, :max_growth_stage, :sprite

  def initialize(type, sprite, max_growth_stage)
    @type = type
    @sprite = sprite
    @growth_stage = 0
    @max_growth_stage = max_growth_stage
  end

  def grow
    @growth_stage += 1 if @growth_stage < @max_growth_stage
  end

  def ready_to_harvest?
    @growth_stage == @max_growth_stage
  end

  def render(args, x, y)
    args.outputs.sprites << {
      x: x * 32,
      y: y * 32,
      w: 32,
      h: 32,
      path: @sprite[@growth_stage]
    }
  end
end

class Crops
  attr_accessor :crop_tiles

  def initialize
    @crop_tiles = {}
  end

  def plant_crop(x, y, type, sprite, max_growth_stage)
    @crop_tiles[[x, y]] = Crop.new(type, sprite, max_growth_stage)
  end

  def grow
    @crop_tiles.each_value(&:grow)
  end

  def harvest(x, y, player)
    crop = @crop_tiles[[x, y]]
    if crop&.ready_to_harvest?
      player.inventory.add_item(:crops, crop.type, { price: Market.new.items_for_sale[:crops][crop.type][:price], image: crop.sprite.last })
      @crop_tiles.delete([x, y])
      puts "Harvested #{crop.type} at (#{x}, #{y})."
    else
      puts "Crop at (#{x}, #{y}) is not ready to harvest."
    end
  end

  def render(args)
    @crop_tiles.each do |(x, y), crop|
      crop.render(args, x, y)
    end
  end
end
