require 'rrobots'

#BillDuck version 0.1
#first working version
#not yet the biggest bot on the playground

class Superbunny
  include Robot
  def tick events
    @rapid_fire = 0 if @rapid_fire.nil?
    @last_seen = 0 if @last_seen.nil?
    @turn_speed = 3 if @turn_speed.nil?

    if time - @last_seen > 200
      @turn_speed *= -1
      @last_seen = time
    end

    turn @turn_speed

    if( @rapid_fire > 0 )
      fire 0.84
      turn_gun -(@turn_speed / @turn_speed) *2
      @rapid_fire = @rapid_fire - 1
    else
      turn_gun @turn_speed * 1.25
    end

    if( !events['robot_scanned'].empty? )
      @turn_speed *= -1
      @last_seen = time
      @rapid_fire = 20
    end
    @last_hit = time unless events['got_hit'].empty?
    if @last_hit && time - @last_hit < 20
      accelerate(-1)
    else
      accelerate 1
    end
  end
end
