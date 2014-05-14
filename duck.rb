require 'rrobots'

class Duck
  include Robot

  def tick events
    move_random
    aimbot
  end

  def move_random
    accelerate -1 + rand(2)
    turn -10 + rand(20)
  end

  def aimbot
    turn_radar 60
    unless events['robot_scanned'].empty?
     puts radar_heading
     turn_gun radar_heading - gun_heading
     #puts radar_heading - gun_heading
     fire 3
    end
  end
end
