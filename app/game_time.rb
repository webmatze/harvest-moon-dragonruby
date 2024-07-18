# game_time.rb

class GameTime
  attr_accessor :current_time, :day_count

  def initialize
    @current_time = 0
    @day_count = 1
  end

  def update(args)
    @current_time += 1

    if @current_time >= args.state.day_length
      @current_time = 0
      @day_count += 1
      new_day(args)
    end
  end

  def new_day(args)
    # Reset daily tasks, grow crops, etc.
    args.state.tasks.reset_tasks
    args.state.crops.grow
    args.state.animals.feed
  end

  def formatted_time
    minutes = (@current_time / (60 * 60)).to_i
    seconds = ((@current_time / 60) % 60).to_i
    format("%02d:%02d", minutes, seconds)
  end

  def render(args)
    args.outputs.labels << [10, 710, "Day: #{@day_count}", 5, 1, 255, 255, 255]
    args.outputs.labels << [10, 680, "Time: #{formatted_time}", 5, 1, 255, 255, 255]
  end
end
