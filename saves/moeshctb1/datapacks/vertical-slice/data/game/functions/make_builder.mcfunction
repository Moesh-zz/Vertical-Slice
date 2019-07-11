#---------------------------------------------------------------------------------------------------
# Purpose: Enable "Builder" systems for player, give items, apply effects
#---------------------------------------------------------------------------------------------------
# Update "class" tags
tag @s[tag=Breaker] remove Breaker
tag @s add Builder

# Remove all effects and apply new ones
effect clear @s
effect give @s minecraft:jump_boost 999999 2 false
effect give @s minecraft:speed 999999 4 false

# Give required items
# Instead of giving scaffolding, we will trigger the refill system to deal with this.
tag @s add RefillScaffolding

# Initialize scoreboards
scoreboard players add @s SneakTime 0

# Announce and remove calling tag
tellraw @a {"translate":"game.classes.builder.joined","with":[{"selector":"@s"}]}
tag @s remove MakeBuilderClass
