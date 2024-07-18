# player.rb

class Player
  attr_accessor :x, :y, :sprite, :tools

  def initialize
    @x = 5
    @y = 5
    @sprite = 'sprites/player/normal.png'
    @tools = {
      hoe: Tool.new('Hoe', 'sprites/tool/hoe.png'),
      sickle: Tool.new('Sickle', 'sprites/tool/sickle.png'),
      watering_can: Tool.new('Watering Can', 'sprites/tool/watering_can.png')
    }
  end

  def handle_input(args)
    if args.inputs.keyboard.key_held.left
      move_left(args)
    elsif args.inputs.keyboard.key_held.right
      move_right(args)
    elsif args.inputs.keyboard.key_held.up
      move_up(args)
    elsif args.inputs.keyboard.key_held.down
      move_down(args)
    end
  end

  def update(args)
    # Update player state if needed
  end

  def render(args)
    args.outputs.sprites << {
      x: @x * 32 + args.state.world_offset_x,
      y: @y * 32 + args.state.world_offset_y,
      w: 32,
      h: 32,
      path: @sprite
    }
  end

  private

  def move_left(args)
    new_x = @x - 1
    if can_move_to?(new_x, @y, args)
      @x = new_x
    end
  end

  def move_right(args)
    new_x = @x + 1
    if can_move_to?(new_x, @y, args)
      @x = new_x
    end
  end

  def move_up(args)
    new_y = @y + 1
    if can_move_to?(@x, new_y, args)
      @y = new_y
    end
  end

  def move_down(args)
    new_y = @y - 1
    if can_move_to?(@x, new_y, args)
      @y = new_y
    end
  end

  def can_move_to?(x, y, args)
    tile = args.state.world.tile_at(x, y)
    return false if tile.nil?
    return false if tile.blocked?
    true
  end
end
