require 'rrobots'

class Littletoaster
  include Robot

  def tick events
    turn_gun(7)
    accelerate 8
    firing
    low_health
  end

  def turning_one
    if time % 3 == 0
      turn Random.rand(2..4)
    else
      turn 1
    end
  end

  def turn_two
      turn -1
  end

    def low_health
      if energy > 91
        turning_one
      else
        turn_two
      end
    end

  def firing
   if events['robot_scanned'].empty?
        fire 0.1
      else
        fire 3
  end
end

end
