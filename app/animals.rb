# animals.rb

class Animals
  attr_accessor :animals

  def initialize
    @animals = []
    populate_initial_animals
  end

  def any?(animal_class)
    @animals.any? { |animal| animal.is_a?(animal_class) }
  end

  def <<(animal)
    @animals << animal
  end

  def each
    @animals.each do |animal|
      yield animal
    end
  end

  def group_by_class
    @animals.group_by { |animal| animal.class }
  end

  def populate_initial_animals
    # Add some initial animals to the farm
    @animals << Cow.new
    @animals << Chicken.new
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
  attr_accessor :sprite, :price, :fed

  def initialize(sprite, price)
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

class Cow < Animal
  def initialize
    super('sprites/animal/cow.png', 100)
  end
end

class Chicken < Animal
  def initialize
    super('sprites/animal/chicken.png', 50)
  end
end
