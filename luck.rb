require 'rrobots'

class Luck
  include Robot

  def tick events
    turn 4
    accelerate 6
    fire 5# unless events['robot_scanned'].empty?
  end
end
