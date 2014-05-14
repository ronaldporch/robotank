require 'rrobots'

class HuntingDuck
include Robot

@time_since=10
@direction=1
@rob_distance=200
end
def rel_direction(from,to)
rel = to -from
if rel > 180
rel = -360 + rel
end
if rel < -180
rel = 360+rel
end
return rel
end
def rel_gun_heading
rel_direction(heading, gun_heading)
end
def tick events
accelerate 1
@rob_distance=events['robot_scanned'][0][0] unless events['robot_scanned'].empty?
if @rob_distance > 800
#make small turret adjustments when distance to enemy is great
turret_turn=3
else
turret_turn=6
end
#turn clockwise or counter clockwise?
@direction = -@direction if Kernel.rand < 0.02
if !events['got_hit'].empty?
#if we got hit we'd better shoot back and try to turn away
fire 2
turn -10*@direction
end
if !events['robot_scanned'].empty?
fire 3
@time_since=0
else
if @time_since < 15
#spotted the enemy, moving closer
#while moving the turret to spot him again
if Kernel.rand < 0.5 && rel_gun_heading < 30
turn_gun turret_turn
elsif rel_gun_heading > -30
turn_gun -turret_turn
else
turn_gun turret_turn
end
fire 0.5
elsif @time_since < 100
#try to spot the enemy
turn 10*@direction
else
#if we got stuck this should get us out
turn 5
end
end
@time_since += 1
end
end
