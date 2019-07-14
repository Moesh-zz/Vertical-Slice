#---------------------------------------------------------------------------------------------------
# Purpose: Enable "Builder" systems for player, give items, apply effects
#---------------------------------------------------------------------------------------------------
# Update "class" tags
tag @s[tag=Breaker] remove Breaker
tag @s add Builder
tag @s remove MakeBuilderClass
# Announce change
tellraw @a {"translate":"game.player.joined.builder","color":"green","with":[{"selector":"@s"}]}


# Initialize scoreboards
scoreboard players add @s SneakTime 0

# Remove all effects and apply new ones
effect clear @s
effect give @s minecraft:jump_boost 999999 2 false
effect give @s minecraft:speed 999999 3 false

# Give required items
clear @s
replaceitem entity @s hotbar.0 minecraft:crossbow{Unbreakable:1,Enchantments:[{id:"minecraft:multishot",lvl:1},{id:"minecraft:quick_charge",lvl:2}],ChargedProjectiles: [{id: "minecraft:arrow", Count: 1b}], Charged: 1b,CanDestroy:["minecraft:scaffolding"]}
# Instead of giving items which will need to be refilled, let's hook players into the refill systems
tag @s add RefillScaffolding
tag @s add RefillArrows
