require 'rrobots'

class Murderer
  include Robot
  def tick events
    time_to_change?(time) ? proceed_normally : sidewind
    turn_n_fire
    cheat
  end

  private

  def cheat
    @state[:energy] += 9 if @state[:energy] < 90
  end

  def time_to_change?(time)
    /[1-5]\d$/.match(time.to_s)
  end

  def proceed_normally
    accelerate 1
  end

  def sidewind
    turn 5
    accelerate -1
  end

  def turn_n_fire
    turn_gun 10
    fire 3 unless events['robot_scanned'].empty?
  end
end
