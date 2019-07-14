#---------------------------------------------------------------------------------------------------
# Purpose: Enable "Breaker" systems for player, give items, apply effects
#---------------------------------------------------------------------------------------------------
# Update "class" tags
tag @s[tag=Builder] remove Builder
tag @s add Breaker
tag @s remove MakeBreakerClass

# Apply effects breakers should have
effect clear @s
effect give @s minecraft:jump_boost 999999 2 false
effect give @s minecraft:speed 999999 3 false
effect give @s minecraft:slow_falling 999999 0 false

tag @s add RefillScaffolding
replaceitem entity @s armor.feet minecraft:diamond_boots{Unbreakable:1,Enchantments:[{id:"minecraft:feather_falling",lvl:4},{id:"minecraft:binding_curse",lvl:1}]}

# Announce change
tellraw @a {"translate":"game.classes.breaker.joined","with":[{"selector":"@s"}]}