# Register on scoreboards
effect give @a[tag=!Registered] minecraft:hunger 1 100 true
scoreboard players add @a[tag=!Registered] sneakTime 0

# Note the player is now registered on all scoreboards
tag @a[tag=!Registered] add Registered

tellraw @a {"translate":"function.ran.register_player","color":"green"}