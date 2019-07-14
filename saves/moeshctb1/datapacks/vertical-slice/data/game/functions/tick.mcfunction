#---------------------------------------------------------------------------------------------------
# Purpose: Run functions when entity is found with tag
#---------------------------------------------------------------------------------------------------
execute as @a[tag=MakeBuilderClass] run function game:make_builder
execute as @a[tag=MakeBreakerClass] run function game:make_breaker

execute if entity @a[tag=!Registered] run function game:register_player

#---------------------------------------------------------------------------------------------------
# Purpose: Refill hunger, but do not overdo saturation
#---------------------------------------------------------------------------------------------------
# Players must not have enough saturation to regenerate their health
execute as @a if score @s foodLevel matches ..19 run effect give @s minecraft:saturation 3 1 true
execute as @a if score @s foodLevel matches 20 run effect clear @s minecraft:saturation

#---------------------------------------------------------------------------------------------------
# Purpose: Give levitation to players who enter chutes when they are not shifting.
#---------------------------------------------------------------------------------------------------
# The most clean version of this mechanic can be done in two lines. This method of adding a layer
# of handling through a tag allows us to run multiple commands that can be ignored if the first
# command is not successful.

# Is the player in scaffolding and not sneaking? Shoot them up.
execute as @a[tag=Builder,tag=!ShootUpChute] at @s anchored feet if block ~ ~ ~ minecraft:scaffolding unless entity @s[scores={sneakTime=1..}] run tag @s add ShootUpChute
execute as @a[tag=ShootUpChute,scores={sneakTime=0}] at @s anchored feet if block ~ ~ ~ minecraft:scaffolding run effect give @s minecraft:levitation 3 23 false
# 
execute as @a[tag=ShootUpChute] at @s anchored feet if block ~ ~ ~ minecraft:air run effect clear @s minecraft:levitation
execute as @a[tag=ShootUpChute] at @s anchored feet if entity @s[scores={sneakTime=1..}] run effect clear @s minecraft:levitation
# Give them a cute little puff of air when they exit the scaffolding
execute as @a[tag=ShootUpChute] at @s anchored feet if block ~ ~ ~ minecraft:air run particle minecraft:cloud ~ ~ ~ 0.5 0.1 0.5 0.1 200 force
execute as @a[tag=ShootUpChute] at @s anchored feet if block ~ ~ ~ minecraft:air run tag @s remove ShootUpChute

# sneakTime increments when a player is crouching (holding SHIFT), reset it after checking to see if
# player has crouched in the last tick.
scoreboard players set @a[scores={sneakTime=1..}] sneakTime 0

#---------------------------------------------------------------------------------------------------
# Purpose: Refill items every 10 seconds
#---------------------------------------------------------------------------------------------------
# Increment the refill timer
scoreboard players add @a[tag=Builder] timeToRefill 1
# When timer hits max
tag @a[tag=Builder,scores={timeToRefill=140}] add RefillItems
clear @a[tag=RefillItems] minecraft:scaffolding

# Give items which need to be refilled.
give @a[tag=Builder,tag=RefillItems] minecraft:scaffolding{CanPlaceOn:["minecraft:emerald_block","minecraft:scaffolding"],CanDestroy:["minecraft:scaffolding"]} 6
replaceitem entity @a[tag=Builder,tag=RefillItems] inventory.26 minecraft:arrow 32
scoreboard players set @a[tag=RefillItems] timeToRefill 0
tag @a[tag=RefillItems] remove RefillItems

#---------------------------------------------------------------------------------------------------
# Purpose: Projectiles should glow when in air. Arrows die in the ground.
#---------------------------------------------------------------------------------------------------
kill @e[type=arrow,nbt={inGround:1b}]
execute as @e[type=arrow] at @s run data merge entity @s {Glowing:1b}
execute as @e[type=trident] at @s run data merge entity @s {Glowing:1b}


#---------------------------------------------------------------------------------------------------
# Purpose: Teleport dropped items back to owners.
#---------------------------------------------------------------------------------------------------
execute if entity @a[scores={droppedItems=1..}] run function game:give_dropped_items_back