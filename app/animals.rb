# animals.rb

class Animals
  attr_accessor :animals

  def initialize
    @animals = []
    populate_initial_animals
  end

  def populate_initial_animals
    # Add some initial animals to the farm
    @animals << Animal.new('cow', 'sprites/animal/cow.png', 100)
    @animals << Animal.new('chicken', 'sprites/animal/chicken.png', 50)
  end

  def feed
    @animals.each do |animal|
      animal.feed
    end
  end

  def update(args)
    @animals.each do |animal|
      animal.update(args)
    end
  end

  def render(args)
    @animals.each do |animal|
      animal.render(args)
    end
  end
end

class Animal
  attr_accessor :type, :sprite, :price, :fed

  def initialize(type, sprite, price)
    @type = type
    @sprite = sprite
    @price = price
    @fed = false
  end

  def feed
    @fed = true
  end

  def update(args)
    # Update animal state if needed
  end

  def render(args)
    # Render the animal on the farm
    args.outputs.sprites << {
      x: rand(0..640), # Random position for demonstration
      y: rand(0..480), # Random position for demonstration
      w: 32,
      h: 32,
      path: @sprite
    }
  end
end
