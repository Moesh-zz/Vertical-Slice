# If player is Builder, they can shoot up chutes.
execute as @a[tag=Builder] at @s anchored feet if block ~ ~ ~ minecraft:scaffolding run tag @s[tag=!ShootUpChute] add ShootUpChute
execute as @a[tag=ShootUpChute] at @s anchored feet if block ~ ~ ~ minecraft:scaffolding run effect give @s minecraft:levitation 3 30 false
execute as @a[tag=ShootUpChute] at @s anchored feet if block ~ ~ ~ minecraft:air run effect clear @s minecraft:levitation
execute as @a[tag=ShootUpChute] at @s anchored feet if block ~ ~ ~ minecraft:air run tag @s remove ShootUpChute

