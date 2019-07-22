# Purpose: Prevent players from dropping items.
# Called from: tick.mcfunction

execute as @e[type=item] run data merge entity @s {PickupDelay:0}
execute as @e[type=item] run data modify entity @s Owner.L set from entity @s Thrower.L
execute as @e[type=item] run data modify entity @s Owner.M set from entity @s Thrower.M
execute as @e[type=item] run teleport @s @p[scores={droppedItems=1..}]
scoreboard players set @a[scores={droppedItems=1..}] droppedItems 0