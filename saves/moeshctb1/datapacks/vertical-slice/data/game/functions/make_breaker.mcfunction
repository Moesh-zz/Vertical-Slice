#---------------------------------------------------------------------------------------------------
# Purpose: Enable "Breaker" systems for player, give items, apply effects
#---------------------------------------------------------------------------------------------------
# Update "class" tags
tag @s[tag=Builder] remove Builder
tag @s add Breaker
tag @s remove MakeBreakerClass
# Announce change
tellraw @a {"translate":"game.player.joined.breaker","color":"green","with":[{"selector":"@s"}]}

# Breakers should have cool items
clear @s
replaceitem entity @s armor.feet minecraft:diamond_boots{Unbreakable:1b,Enchantments:[{id:"minecraft:binding_curse",lvl:1s}],AttributeModifiers:[{AttributeName:"generic.maxHealth",Name:"generic.maxHealth",Amount:-10,Operation:0,UUIDLeast:880888,UUIDMost:52257,Slot:"feet"}]}
replaceitem entity @s hotbar.0 minecraft:trident{CanDestroy:["minecraft:scaffolding"],Unbreakable:1b,Enchantments:[{id:"minecraft:binding_curse",lvl:1s},{id:"minecraft:riptide",lvl:2s}]} 1


# Apply effects breakers should have
effect clear @s
effect give @s minecraft:jump_boost 999999 2 false
effect give @s minecraft:speed 999999 3 false
effect give @s minecraft:slow_falling 999999 0 false

tag @s add RefillScaffolding