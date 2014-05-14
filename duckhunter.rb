require 'rrobots'

class DuckHunter
  include Robot

  def tick events
    size = 1 if time == 0
    move_random
    aimbot
  end

  def move_random
    accelerate -1 + rand(2)
    turn -5 + rand(10)
  end

  def aimbot
    turn_radar 60
    unless events['robot_scanned'].empty?
     turn_gun radar_heading - gun_heading
     fire 3
    end
  end
end
