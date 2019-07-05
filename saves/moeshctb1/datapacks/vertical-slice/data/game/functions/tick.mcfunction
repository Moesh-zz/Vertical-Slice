# If player is Builder, they can shoot up chutes.
    # The most clean version of this mechanic can be done in two lines.
    # This method of adding a layer of handling through a tag allows us
    # to run multiple commands that can be ignored if the first command
    # is not successful.
execute as @a[tag=Builder,tag=!ShootUpChute] at @s anchored feet if block ~ ~ ~ minecraft:scaffolding unless entity @s[scores={SneakTime=1..}] run tag @s add ShootUpChute
execute as @a[tag=ShootUpChute,scores={SneakTime=0}] at @s anchored feet if block ~ ~ ~ minecraft:scaffolding run effect give @s minecraft:levitation 3 30 false
execute as @a[tag=ShootUpChute] at @s anchored feet if block ~ ~ ~ minecraft:air run effect clear @s minecraft:levitation
execute as @a[tag=ShootUpChute] at @s anchored feet if entity @s[scores={SneakTime=1..}] run effect clear @s minecraft:levitation
execute as @a[tag=ShootUpChute] at @s anchored feet if block ~ ~ ~ minecraft:air run tag @s remove ShootUpChute
effect clear @s[scores={SneakTime=1..}] minecraft:levitation
scoreboard players set @a[scores={SneakTime=1..}] SneakTime 0

# If player is builder, they are refilled to 32 scaffolding every 10 seconds
scoreboard players add @a[tag=Builder] timeToRefill 1
tag @a[tag=Builder,scores={timeToRefill=200}] add RefillScaffolding
clear @a[tag=RefillScaffolding] minecraft:scaffolding
give @a[tag=RefillScaffolding] minecraft:scaffolding{CanPlaceOn:["minecraft:iron_block","minecraft:scaffolding"],CanDestroy:["minecraft:scaffolding"]} 32
scoreboard players set @a[tag=RefillScaffolding] timeToRefill 0
tag @a[tag=RefillScaffolding] remove RefillScaffolding