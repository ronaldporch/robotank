require 'rrobots'

#BillDuck version 0.1
#first working version
#not yet the biggest bot on the playground

class Erik
  include Robot
  def tick events
    accelerate 1 if velocity < 7
    if close_to_edge
      turn_towards_quadrant get_other_quadrant
    end
    @post_hit_turn ||= 0
    if !events['got_hit'].empty?
      @post_hit_turn = 10
    end
    if @post_hit_turn > 0
      if @post_hit_turn < 70
        turn 10
        @post_hit_turn += 10
      else
        @post_hit_turn = 0
      end
    end

    @gun_turn_back ||= 50
    @robot_sighted ||= 0
    @fire_in_ticks ||= 2
    if !events['robot_scanned'].empty? and @gun_turn_back > 40
      @robot_sighted = radar_heading
      @turnstep = -5
      @gun_turn_back = 10
      @distance = events['robot_scanned'][0][0]
      if @distance < 500 then fire 3 end
    else
      if @gun_turn_back == 20
        turn_gun @turnstep
        @gun_turn_back += 10
        if @distance < 500
          fire 3
        else
          fire 1
        end
      elsif @gun_turn_back <= 40
        turn_gun @turnstep
        @gun_turn_back += 10
      else
        turn_gun 10
      end
    end

  end

  def close_to_edge
    margins = [x, (x - battlefield_width).abs, y, (y - battlefield_height).abs]
    true if margins.min < 200
  end

  def get_other_quadrant
    other = quadrant
    until other != quadrant do
        other = (rand * 4).to_i
      end
      other
    end

    # Return 1, 2, 3, 4 depending on which quadrant of the battlefield the robot is in
    # -----
    # |1 2|
    # |3 4|
    # -----
    def quadrant
      left = x < battlefield_width / 2
      right = !right
      top = y < battlefield_height / 2
      bottom = !top
      if left and top
        1
      elsif right and top
        2
      elsif left and bottom
        3
      else
        4
      end
    end

    def simple_heading
      if (heading <= 90)
        "ne"
      elsif (heading > 90) and (heading <= 180)
        "nw"
      elsif (heading > 180) and (heading <= 270)
        "sw"
      else
        "se"
      end
    end

    def turn_towards_quadrant(target_quadrant)
      case quadrant
      when 1
        case target_quadrant
        when 2
          if simple_heading != "ne" then turn 20 end
        when 3
          if simple_heading != "sw" then turn 20 end
        when 4
          if simple_heading != "se" then turn 20 end
        end
      when 2
        case target_quadrant
        when 1
          if simple_heading != "nw" then turn 20 end
        when 3
          if simple_heading != "sw" then turn 20 end
        when 4
          if simple_heading != "se" then turn 20 end
        end
      when 3
        case target_quadrant
        when 1
          if simple_heading != "nw" then turn 20 end
        when 2
          if simple_heading != "ne" then turn 20 end
        when 4
          if simple_heading != "se" then turn 20 end
        end
      when 4
        case target_quadrant
        when 1
          if simple_heading != "nw" then turn 20 end
        when 2
          if simple_heading != "ne" then turn 20 end
        when 3
          if simple_heading != "sw" then turn 20 end
        end
      end
    end
  end
