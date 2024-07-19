# world.rb

class World
  attr_accessor :tiles

  def initialize
    @tiles = Array.new(20) { Array.new(20) { Tile.new('soil', 'sprites/soil/normal.png') } }
    generate_world
  end

  def generate_world
    # Example of generating some paths and walls
    (0..19).each do |i|
      @tiles[0][i] = Tile.new('wall', 'sprites/wall/wood.png', true)
      @tiles[19][i] = Tile.new('wall', 'sprites/wall/wood.png', true)
      @tiles[i][0] = Tile.new('wall', 'sprites/wall/wood.png', true)
      @tiles[i][19] = Tile.new('wall', 'sprites/wall/wood.png', true)
    end

    @tiles[15][10] = Tile.new('path', 'sprites/wall/wood.png', true)
    @tiles[15][11] = Tile.new('path', 'sprites/wall/wood.png', true)
    @tiles[15][12] = Tile.new('path', 'sprites/wall/wood.png', true)
    @tiles[15][13] = Tile.new('path', 'sprites/wall/wood.png', true)
    @tiles[15][14] = Tile.new('path', 'sprites/wall/wood.png', true)
    @tiles[15][15] = Tile.new('path', 'sprites/wall/wood.png', true)
    @tiles[15][16] = Tile.new('path', 'sprites/wall/wood.png', true)
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
