# Purpose: Main clock
# Called from: N/A

#---------------------------------------------------------------------------------------------------
# Purpose: Run functions when entity is found with tag
#---------------------------------------------------------------------------------------------------
execute if entity @a[tag=!Registered] run function game:register_player

execute as @a[tag=MakeBuilderClass] run function game:change_to_builder
execute as @a[tag=MakeBreakerClass] run function game:change_to_breaker


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
# Purpose: Detect when player is in the air and just used a trident, apply glowing and break the
#		   breakable blocks.
#---------------------------------------------------------------------------------------------------
# Has the player used a Trident to riptide? Make them break blocks.
execute as @a[tag=Breaker,nbt={OnGround:0b},scores={usedTrident=1}] run tag @s add BreakBlocks
scoreboard players set @a[tag=BreakBlocks] usedTrident 0

# If they aren't glowing, make them glow.
execute as @a[tag=BreakBlocks,nbt={Glowing:0b}] run effect give @s minecraft:glowing 999999 0 true

# Increment the refill timer
scoreboard players add @a[tag=BreakBlocks] riptideTime 1

execute as @a[tag=BreakBlocks] at @s anchored eyes run fill ~ ~ ~ ^3 ^2 ^3 minecraft:air replace minecraft:diamond_block

# Riptide is done, stop!
execute as @a[tag=BreakBlocks,scores={riptideTime=20}] run tag @s add StopBreakingBlocks
execute as @a[tag=StopBreakingBlocks] run effect clear @s minecraft:glowing
execute as @a[tag=StopBreakingBlocks] run scoreboard players set @s riptideTime 0
execute as @a[tag=StopBreakingBlocks] run tag @s remove BreakBlocks
execute as @a[tag=StopBreakingBlocks] run tag @s remove StopBreakingBlocks

#---------------------------------------------------------------------------------------------------
# Purpose: Teleport dropped items back to owners.
#---------------------------------------------------------------------------------------------------
execute if entity @a[scores={droppedItems=1..}] run function game:give_dropped_items_back