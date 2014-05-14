require 'rrobots'

class Chapagetti2
  include Robot

  def tick events
    say speed
    turn_radar 1 if time == 0
    turn_gun 15
    drive = 1
    accelerate drive
    fire 3 unless events['robot_scanned'].empty?
  end 
end
