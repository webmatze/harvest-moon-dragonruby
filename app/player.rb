# player.rb

class Player
  attr_accessor :x, :y, :sprite, :tools

  def initialize
    @x = 4 * 32
    @y = 4 * 32
    @sprite = 'sprites/player/front.png'
    @tools = {
      hoe: Tool.new('Hoe', 'sprites/tool/hoe.png'),
      sickle: Tool.new('Sickle', 'sprites/tool/sickle.png'),
      watering_can: Tool.new('Watering Can', 'sprites/tool/watering_can.png')
    }
    @speed = 4  # pixels per frame
  end

  def handle_input(args)
    if args.inputs.keyboard.key_held.left
      move_left(args)
    elsif args.inputs.keyboard.key_held.right
      move_right(args)
    end
    if args.inputs.keyboard.key_held.up
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
      x: @x + args.state.world_offset_x,
      y: @y + args.state.world_offset_y,
      w: 32,
      h: 48,
      path: @sprite
    }
  end

  private

  def move_left(args)
    new_x = @x - @speed
    if can_move_to?(new_x, @y, args)
      @x = new_x
    end
  end

  def move_right(args)
    new_x = @x + @speed
    if can_move_to?(new_x, @y, args)
      @x = new_x
    end
  end

  def move_up(args)
    new_y = @y + @speed
    if can_move_to?(@x, new_y, args)
      @y = new_y
    end
  end

  def move_down(args)
    new_y = @y - @speed
    if can_move_to?(@x, new_y, args)
      @y = new_y
    end
  end

  def can_move_to?(x, y, args)
    # Check all four corners of the player sprite
    corners = [
      [x + 4, y + 4],                  # Bottom-left
      [x + 27, y + 4],             # Bottom-right
      [x + 4, y + 27],             # Top-left
      [x + 27, y + 27]         # Top-right
    ]

    corners.each do |corner_x, corner_y|
      tile_x = (corner_x / 32).floor
      tile_y = (corner_y / 32).floor
      tile = args.state.world.tile_at(tile_x, tile_y)
      return false if tile.nil? || tile.solid?
    end

    true
  end
end
