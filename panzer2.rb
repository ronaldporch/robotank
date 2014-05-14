require 'rrobots'

class Panzer2
  @movement_status = ""
  include Robot
  @turn

  dead = false

  def tick events
    size = 1 if time == 0
    accelerate 1
    if rand(10) >= 1
      circle
      @movement_status = "circle"
    else
      straight
      @movement_status = "straight"
    #move_random
    end
    aimbot
    say("(" + x.to_int.to_s + " ," + y.to_int.to_s + ") " + @movement_status.to_s)
  end

  def circle
    turn 2
    accelerate 1
  end

  def straight
    turn -2
    accelerate 1
  end

  def move_random
    accelerate -1 + rand(2)
    @turn = turn -5 + rand(10)
    battlefield_height - size - y < 100
    battlefield_width - size - x < 100
  end

  def aimbot
    turn_radar 60
    unless events['robot_scanned'].empty?
     turn_gun radar_heading - gun_heading - 45#- @turn
     fire 1
     #puts radar_heading - gun_heading - @turn - 45
    end
  end
end
