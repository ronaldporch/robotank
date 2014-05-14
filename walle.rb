require "rrobots"

class WallE
  include Robot

  def tick events
    @last_heading ||= heading
    #say "Going " + direction(heading).to_s
    dont_get_stuck

    if time <= 15
      turn_gun 5
    else
      turn_gun(time.to_s.match(/\d$/).to_s.to_i > 5 ? 4 : -3)
      if gun_heading-90 > heading + 70 || gun_heading-90 < heading - 70
        turn_gun -20
      end
    end

    fire 0.3
    @last_energy = energy
  end

  def dont_get_stuck
    unless at_edge_of_screen?
      accelerate 1
      @last_heading = heading
    else
      turn 10
    end
  end

  def at_edge_of_screen?
    x <= size || x >= battlefield_width - size || y <= size || y >= battlefield_height - size
  end

  def spin_like_a_maniac
    turn -10
    fire 0.1
  end

  def direction(heading)
    if heading <= 23 || heading > 337
      return [:east, :east]
    elsif heading > 23 || heading <= 67
      return [:east, :north]
    elsif heading > 67 || heading <= 112
      return [:north, :north]
    elsif heading > 112 || heading <= 157
      return [:north, :west]
    elsif heading > 157 || heading <= 202
      return [:west, :west]
    elsif heading > 202 || heading <= 248
      return [:west, :south]
    elsif heading > 248 || heading <= 292
      return [:south, :south]
    else
      return [:south, :east]
    end
  end

  def quick_turn(heading, speed)
    direction = (1 + rand(2)).even? ? "negative" : "positive"
    if direction == "positive"
      unless heading < @last_heading
        turn speed
      end
    else
      unless heading > @last_heading
        turn -speed
      end
    end
  end

end
