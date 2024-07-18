# main.rb

require 'smaug.rb'
require 'app/player.rb'
require 'app/tile.rb'
require 'app/world.rb'
require 'app/tools.rb'
require 'app/market.rb'
require 'app/game_time.rb'
require 'app/tasks.rb'
require 'app/animals.rb'
require 'app/crops.rb'
require 'app/inventory.rb'
require 'app/ui.rb'

def tick(args)
  # Initialize game state on the first tick
  if args.state.tick_count == 0
    init_game(args)
  end

  # Update game time
  args.state.game_time.update(args)

  # handle game input
  handle_input(args)

  # Handle player input and movement
  args.state.player.handle_input(args)
  args.state.player.update(args)

  # Update world state
  args.state.world.update(args)

  # Render the game
  render(args)
end

def init_game(args)
  # Initialize some game constants
  args.state.world_offset_x = 40
  args.state.world_offset_y = 40
  args.state.day_length = 2 * 60 * 60 # 2 minutes in ticks (60 ticks per second)

  # Initialize game time
  args.state.game_time = GameTime.new

  # Initialize player
  args.state.player = Player.new

  # Initialize world
  args.state.world = World.new

  # Initialize UI
  args.state.ui = UI.new

  # Initialize other game components as needed
  args.state.inventory = Inventory.new
  args.state.market = Market.new
  args.state.tasks = Tasks.new
end

def render(args)
  # Clear the screen
  args.outputs.background_color = [0, 0, 0]

  # Render the world
  args.state.world.render(args)

  # Render the player
  args.state.player.render(args)

  # Render the UI
  args.state.ui.render(args)
end

def handle_input(args)
  # add a cow to the inventory
  if args.inputs.keyboard.key_down.c
    args.state.inventory.add_item(:animals, Cow)
  end
  # add a chicken to the inventory
  if args.inputs.keyboard.key_down.v
    args.state.inventory.add_item(:animals, Chicken)
  end
end
