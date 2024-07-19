# tasks.rb

class Tasks
  attr_accessor :daily_tasks, :completed_tasks

  def initialize
    @daily_tasks = []
    @completed_tasks = []
    generate_daily_tasks
  end

  def generate_daily_tasks
    @daily_tasks = [
      { task: 'plant_crops', description: 'Plant crops in the soil' },
      { task: 'water_crops', description: 'Water the planted crops' },
      { task: 'harvest_crops', description: 'Harvest the grown crops' },
      { task: 'feed_animals', description: 'Feed the cows and chickens' }
    ]
  end

  def complete_task(task_name)
    task = @daily_tasks.find { |t| t[:task] == task_name }
    if task
      @completed_tasks << task
      @daily_tasks.delete(task)
    end
  end

  def reset_tasks
    @completed_tasks.clear
    generate_daily_tasks
  end

  def update(args)
    # Check if all tasks are completed for the day
    if @daily_tasks.empty?
      puts "All tasks for the day are completed!"
    end
  end

  def render(args)
    # Render the list of daily tasks on the screen
    args.outputs.labels << {
      x: 720,
      y: 310,
      text: "Daily Tasks:",
      size_enum: 2,
      font: UI::FONT
    }.merge(UI::WHITE_COLOR)

    @daily_tasks.each_with_index do |task, index|
      args.outputs.labels << {
        x: 720 + 30,
        y: 250 - (index * 30),
        text: "- #{task[:description]}",
        size_enum: 1,
        font: UI::FONT
      }.merge(UI::WHITE_COLOR)
    end
  end
end
