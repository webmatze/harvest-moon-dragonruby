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

    @tiles[10][10] = Tile.new('path', 'sprites/path/normal.png')
    @tiles[10][11] = Tile.new('path', 'sprites/path/normal.png')
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
    return nil if x < 0 || y < 0 || x >= @tiles.length || y >= @tiles[0].length
    @tiles[x][y]
  end
end
