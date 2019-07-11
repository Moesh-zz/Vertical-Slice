#---------------------------------------------------------------------------------------------------
# Purpose: Enable "Builder" systems for player, give items, apply effects
#---------------------------------------------------------------------------------------------------
# Update "class" tags
tag @s[tag=Breaker] remove Breaker
tag @s add Builder
tag @s remove MakeBuilderClass

# Remove all effects and apply new ones
effect clear @s
effect give @s minecraft:jump_boost 999999 2 false
effect give @s minecraft:speed 999999 4 false

# Give required items
replaceitem entity @s hotbar.0 minecraft:crossbow{Unbreakable:1,Enchantments:[{id:"minecraft:multishot",lvl:1}]}
# Instead of giving new durable items, let's look players into the item refill system
tag @s add RefillScaffolding
tag @s add RefillArrows

# Initialize scoreboards
scoreboard players add @s SneakTime 0

# Announce change
tellraw @a {"translate":"game.classes.builder.joined","with":[{"selector":"@s"}]}
