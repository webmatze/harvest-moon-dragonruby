# tile.rb

class Tile
  attr_accessor :type, :blocked, :sprite

  def initialize(type, sprite, blocked = false)
    @type = type
    @sprite = sprite
    @blocked = blocked
  end

  def blocked?
    @blocked
  end

  def render(args, x, y)
    args.outputs.sprites << {
      x: x * 32 + args.state.world_offset_x,
      y: y * 32 + args.state.world_offset_y,
      w: 32,
      h: 32,
      path: @sprite
    }
  end
end
