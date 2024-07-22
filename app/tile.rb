# tile.rb

class Tile
  attr_accessor :type, :sprite_id, :solid

  def initialize(type, sprite_id, solid = false)
    @type = type
    @sprite_id = sprite_id
    @solid = solid
  end

  def render(args, x, y, spritesheet)
    spritesheet_width = 192  # Width of the spritesheet in pixels
    sprites_per_row = spritesheet_width / 32  # Number of sprites per row

    sprite_x = (sprite_id % sprites_per_row) * 32
    sprite_y = (sprite_id / sprites_per_row).floor * 32

    args.outputs.sprites << {
      x: x * 32 + args.state.world_offset_x,
      y: y * 32 + args.state.world_offset_y,
      w: 32,
      h: 32,
      path: spritesheet,
      source_x: sprite_x,
      source_y: sprite_y,
      source_w: 32,
      source_h: 32
    }
  end

  def solid?
    @solid
  end
end
