# ui.rb

class UI
  WHITE_COLOR = { r: 255, g: 255, b: 255, a: 255 }
  FONT = 'fonts/DiaryOfAn8BitMage-lYDD.ttf'

  def render(args)
    render_inventory(args)
    render_game_time(args)
    render_money(args)
    render_tasks(args)
  end

  private

  def render_inventory(args)
    args.state.inventory.render(args)
  end

  def render_game_time(args)
    game_time = args.state.game_time
    time_text = "Day #{game_time.day_count}, Time: #{format_time(game_time.current_time)}"
    args.outputs.labels << { x: 720, y: 700, text: time_text, size_enum: 2, alignment_enum: 0, font: FONT }.merge(WHITE_COLOR)
  end

  def render_money(args)
    money = args.state.inventory.money
    args.outputs.labels << { x: 720, y: 670, text: "Money: $#{money}", size_enum: 2, alignment_enum: 0, font: FONT }.merge(WHITE_COLOR)
  end

  def render_tasks(args)
    tasks = args.state.tasks.render(args)
  end

  def format_time(ticks)
    total_seconds = ticks / 60
    minutes = total_seconds / 60
    seconds = total_seconds % 60
    format("%02d:%02d", minutes, seconds)
  end
end
