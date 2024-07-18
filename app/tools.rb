# tools.rb

class Tool
  attr_accessor :name, :sprite, :durability

  def initialize(name, sprite, durability = 100)
    @name = name
    @sprite = sprite
    @durability = durability
  end

  def use
    @durability -= 1
    if @durability <= 0
      puts "#{@name} is broken and needs to be repaired or replaced."
    end
  end

  def repair
    @durability = 100
  end

  def render(args, x, y)
    args.outputs.sprites << {
      x: x,
      y: y,
      w: 32,
      h: 32,
      path: @sprite
    }
  end
end

class Hoe < Tool
  def initialize
    super('Hoe', 'sprites/tool/hoe.png')
  end

  def use_on_tile(tile)
    if tile.type == 'soil'
      tile.type = 'tilled_soil'
      tile.sprite = 'sprites/soil/tilled.png'
      use
    else
      puts "You can't use the hoe here."
    end
  end
end

class Sickle < Tool
  def initialize
    super('Sickle', 'sprites/tool/sickle.png')
  end

  def use_on_tile(tile)
    if tile.type == 'plant'
      tile.type = 'soil'
      tile.sprite = 'sprites/soil/normal.png'
      use
    else
      puts "You can't use the sickle here."
    end
  end
end

class WateringCan < Tool
  attr_accessor :water_level

  def initialize
    super('Watering Can', 'sprites/tool/watering_can.png')
    @water_level = 10
  end

  def use_on_tile(tile)
    if @water_level > 0
      if tile.type == 'tilled_soil'
        tile.type = 'watered_soil'
        tile.sprite = 'sprites/soil/watered.png'
        @water_level -= 1
        use
      else
        puts "You can't water this tile."
      end
    else
      puts "The watering can is empty."
    end
  end

  def refill
    @water_level = 10
  end
end
