# If player is Builder, they can shoot up chutes.
    # The most clean version of this mechanic can be done in two lines.
    # This method of adding a layer of handling through a tag allows us
    # to run multiple commands that can be ignored if the first command
    # is not successful.
execute as @a[tag=Builder] at @s anchored feet if block ~ ~ ~ minecraft:scaffolding run tag @s[tag=!ShootUpChute] add ShootUpChute
execute as @a[tag=ShootUpChute] at @s anchored feet if block ~ ~ ~ minecraft:scaffolding run effect give @s minecraft:levitation 3 30 false
execute as @a[tag=ShootUpChute] at @s anchored feet if block ~ ~ ~ minecraft:air run effect clear @s minecraft:levitation
execute as @a[tag=ShootUpChute] at @s anchored feet if block ~ ~ ~ minecraft:air run tag @s remove ShootUpChute

# If player is builder, they are refilled to 32 scaffolding every 10 seconds
scoreboard players add @a[tag=Builder] timeToRefill 1

tag add @a[tag=Builder,scores={timeToRefill=200}] RefillScaffolding
scoreboard players set @a[tag=RefillScaffolding] timeToRefill 0
scoreboard players set @a[tag=RefillScaffolding] timeToRefill 0