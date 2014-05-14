require 'rrobots'

class Luck2
  include Robot

  def tick events
    turn 4
    accelerate 5
    fire 3 unless events['robot_scanned'].empty?
  end
end
