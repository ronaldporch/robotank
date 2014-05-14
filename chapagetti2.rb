require 'rrobots'

class Chapagetti2
  include Robot

  def tick events
    say speed
    turn_radar 1 if time == 0
    turn_gun 7
    if time % 11 == 0
      turn rand(10)
    else
      accelerate -1 + rand(2)
    end
    fire 0.1
    fire 3 unless events['robot_scanned'].empty?
  end 
end
