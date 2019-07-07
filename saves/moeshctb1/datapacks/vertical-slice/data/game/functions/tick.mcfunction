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
execute as @s[tag=Registered,scores={foodLevel=..19}] at @s run effect give @s minecraft:saturation 1 0 true
execute as @s[tag=Registered,scores={foodLevel=20}] at @s run effect clear @s minecraft:saturation
execute as @s[tag=Registered,scores={foodLevel=..19}] at @s run say hi

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
# Purpose: Refill Scaffolding every 10 seconds
#---------------------------------------------------------------------------------------------------
# Increment the refill timer
scoreboard players add @a[tag=Builder] timeToRefill 1
# When timer hits max

tag @a[tag=Builder,scores={timeToRefill=200}] add RefillScaffolding
clear @a[tag=RefillScaffolding] minecraft:scaffolding
give @a[tag=RefillScaffolding] minecraft:scaffolding{CanPlaceOn:["minecraft:iron_block","minecraft:scaffolding"],CanDestroy:["minecraft:scaffolding"]} 12
scoreboard players set @a[tag=RefillScaffolding] timeToRefill 0
tag @a[tag=RefillScaffolding] remove RefillScaffolding

