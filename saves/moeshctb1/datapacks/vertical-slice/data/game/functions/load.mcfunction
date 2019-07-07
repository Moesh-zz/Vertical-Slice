
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

# Set to true during development time
gamerule commandBlockOutput true
gamerule logAdminCommands true
gamerule sendCommandFeedback true

# Probably don't change
gamerule maxCommandChainLength 65536
gamerule maxEntityCramming 0
gamerule randomTickSpeed 3
gamerule reducedDebugInfo false
gamerule disableElytraMovementCheck true
gamerule spectatorsGenerateChunks false
gamerule spawnRadius 7

# Set specific rules for this map
gamerule doDaylightCycle false
gamerule keepInventory true
gamerule doTileDrops false
gamerule doWeatherCycle false
weather rain 1000000
gamerule showDeathMessages true
gamerule naturalRegeneration true

# Disable mechanics that was not relevant
gamerule disableRaids false
gamerule doLimitedCrafting true
gamerule announceAdvancements false
gamerule doEntityDrops false
gamerule doFireTick true
gamerule doMobLoot false
gamerule doMobSpawning false
gamerule mobGriefing false

#---------------------------------------------------------------------------------------------------
# Purpose: Run follow-up functions to handle players currently in-game
#---------------------------------------------------------------------------------------------------
tag @a remove Registered

tellraw @a {"translate":"function.ran.load","color":"green"}