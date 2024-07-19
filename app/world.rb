# world.rb

class World
  attr_accessor :tiles, :map_data

  def initialize(map_path)
    @map_data = SpriteFusion::Tilemap.load($gtk.parse_json_file(map_path))
    @tiles = Array.new(@map_data.map_height) { Array.new(@map_data.map_width) { Tile.new('soil', 'sprites/soil/normal.png') } }
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
      return Tile.new('house', 'sprites/house/wood.png', true)
    when "1"
      return Tile.new('house', 'sprites/house/roof.png', true)
    when "2"
      return Tile.new('house', 'sprites/house/door.png', true)
    when "3"
      return Tile.new('wall', 'sprites/wall/wood.png', true)
    when "4"
      return Tile.new('soil', 'sprites/soil/normal.png')
    when "5"
      return Tile.new('path', 'sprites/path/normal.png')
    end
  end

  def update(args)
    # Update world state if needed
  end

  def render(args)
    @tiles.each_with_index do |row, y|
      row.each_with_index do |tile, x|
        tile.render(args, x, y)
      end
    end
  end

  def tile_at(x, y)
    return nil if x < 0 || y < 0 || y >= @tiles.length || x >= @tiles[0].length
    @tiles[y][x]
  end
end
