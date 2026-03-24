/datum/charflaw/averse
	name = "Averse"
	desc = "You loathe a specific faction or group."
	var/faction_type // Which faction this character loathes

/datum/charflaw/averse/on_mob_creation(mob/user)
	. = ..()
	// TODO: Implement faction-based penalties

