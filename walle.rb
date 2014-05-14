require "rrobots"

class WallE
  include Robot
  def initialize
    super
    @last_energy = 100
  end

  def tick events
    @last_heading ||= heading

    turn_gun 5 if time <= 15

    # if energy > 75
    #   spin_like_a_maniac
    # end
    dont_get_stuck


    fire 0.1 #unless events['robot_scanned'].empty?

    @last_energy = energy
  end

  def dont_get_stuck
    unless at_edge_of_screen?
      # unless speed >= 5
      #   accelerate 1
      # end
      accelerate 1
      @last_heading = heading
    else
      turn 10
    end
  end

  def match_heading_to_radar
    get_diff = heading - radar_heading
    turn get_diff/10
  end

  def at_edge_of_screen?
    x <= size || x >= battlefield_width - size || y <= size || y >= battlefield_height - size
  end

  def spin_like_a_maniac
    turn -10
    fire 0.1
  end

  def quick_turn(heading)
    direction = (1 + rand(2)).even? ? "negative" : "positive"
    if direction == "positive"
      unless heading < @last_heading
        turn 10
      end
    else
      unless heading > @last_heading
        turn -10
      end
    end
  end

end
