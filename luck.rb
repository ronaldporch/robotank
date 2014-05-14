require 'rrobots'

class Luck
  include Robot

  def tick events
    turn 4
    accelerate 8
    fire 3 #unless events['robot_scanned'].empty?
  end
end
