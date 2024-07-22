# world.rb

class World
  attr_accessor :tiles, :map_data, :spritesheet

  def initialize(map_path)
    @map_data = SpriteFusion::Tilemap.load($gtk.parse_json_file(map_path))
    @tiles = Array.new(@map_data.map_height) { Array.new(@map_data.map_width) { Tile.new('soil', 4) } }
    @spritesheet = 'maps/map/spritesheet.png'
    generate_world
  end

  def generate_world
    @map_data.layers.reverse.each do |layer|
      layer.tiles.each do |tile|
        @tiles[@map_data.map_height - tile.y - 1][tile.x] = get_tile(tile.id)
      end
    end
  end

  def get_tile(id)
    case id
    when "0"
      Tile.new('house', id.to_i, true)
    when "1"
      Tile.new('house', id.to_i, true)
    when "2"
      Tile.new('house', id.to_i, true)
    when "3"
      Tile.new('wall', id.to_i, true)
    when "4"
      Tile.new('soil', id.to_i)
    when "5"
      Tile.new('path', id.to_i)
    end
  end

  def update(args)
    # Update world state if needed
  end

  def render(args)
    @tiles.each_with_index do |row, y|
      row.each_with_index do |tile, x|
        tile.render(args, x, y, @spritesheet)
      end
    end
  end

  def tile_at(x, y)
    return nil if x < 0 || y < 0 || y >= @tiles.length || x >= @tiles[0].length
    @tiles[y][x]
  end
end
