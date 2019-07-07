
#---------------------------------------------------------------------------------------------------
# Purpose: Initialize session objectives
#---------------------------------------------------------------------------------------------------
# If a variable must persist from session to session, use a different file to initialize objectives.

scoreboard objectives remove timeToRefill
scoreboard objectives add timeToRefill dummy
	scoreboard players set #RefillScaffolding timeToRefill 200

scoreboard objectives remove sneakTime
scoreboard objectives add sneakTime minecraft.custom:minecraft.sneak_time

scoreboard objectives remove foodLevel
scoreboard objectives add foodLevel food

# We're in development, give me a preview of an objective
scoreboard objectives setdisplay sidebar foodLevel

#---------------------------------------------------------------------------------------------------
# Purpose: Set all game rules
#---------------------------------------------------------------------------------------------------
#gamerule announceAdvancements
#gamerule disableElytraMovementCheck
#gamerule commandBlockOutput
#gamerule disableRaids
#gamerule doDaylightCycle

#---------------------------------------------------------------------------------------------------
# Purpose: Run follow-up functions to handle players currently in-game
#---------------------------------------------------------------------------------------------------
tag @a remove Registered

tellraw @a {"translate":"function.ran.load","color":"green"}