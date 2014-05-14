require 'rrobots'

class Luck2
  include Robot

  def tick events
    turn 5 if time > 3
    turn_gun 6
    accelerate 8
    fire 3 unless events['robot_scanned'].empty?
  end
end
