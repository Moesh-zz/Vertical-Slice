#---------------------------------------------------------------------------------------------------
# Purpose: Enable "Builder" systems for player, give items, apply effects
#---------------------------------------------------------------------------------------------------
tag @s[tag=Breaker] remove Breaker
tag @s add Builder

# Remove all effects and apply new ones
effect clear @s
effect give @s minecraft:jump_boost 999999 2 false
effect give @s minecraft:speed 999999 4 false

# Give required items
# Instead of giving scaffolding, we will trigger the refill system to deal with this.

tag @s add RefillScaffolding
replaceitem entity @s armor.feet minecraft:diamond_boots{Unbreakable:1,Enchantments:[{id:"minecraft:feather_falling",lvl:4},{id:"minecraft:binding_curse",lvl:1}]}

# Initialize on scoreboard
scoreboard players add @s SneakTime 0

tellraw @a {"translate":"game.classes.builder.joined","with":[{"selector":"@s"}]}
tag @s remove MakeBuilderClass
