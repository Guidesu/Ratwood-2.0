/datum/patron/divine/astrata
	name = "Solarius"
	domain = "The Sun, Justice, Order, Dawn"
	desc = "The Radiant Judge was gravely wounded in the Godswar against the Titans. Though weakened, His burning light still pierces all falsehood and drives back the creatures of chaos. By His blessing, nobility is granted the right to rule, and by His law, order is maintained. Valorax the Battleborn stands at His side to ensure justice does not become tyranny."
	worshippers = "Nobility, Paladins, The Righteous, Judges"
	mob_traits = list(TRAIT_APRICITY)
	miracles = list(/obj/effect/proc_holder/spell/targeted/touch/orison			= CLERIC_ORI,
					/obj/effect/proc_holder/spell/invoked/ignition				= CLERIC_T0,
					/obj/effect/proc_holder/spell/self/astrata_gaze				= CLERIC_T0,
					/obj/effect/proc_holder/spell/invoked/lesser_heal 			= CLERIC_T1,
					/obj/effect/proc_holder/spell/invoked/blood_heal			= CLERIC_T1,
					/obj/effect/proc_holder/spell/self/astratan_path			= CLERIC_T1,
					/obj/effect/proc_holder/spell/invoked/heal					= CLERIC_T2,
					/obj/effect/proc_holder/spell/invoked/revive				= CLERIC_T3,
					/obj/effect/proc_holder/spell/invoked/immolation			= CLERIC_T4,
	)
	confess_lines = list(
		"SOLARIUS IS MY LIGHT!",
		"SOLARIUS BRINGS JUSTICE!",
		"I SERVE THE RADIANT JUDGE!",
	)
	storyteller = /datum/storyteller/astrata

// In daylight, church, cross, or ritual chalk.
/datum/patron/divine/astrata/can_pray(mob/living/follower)
	. = ..()
	// Allows prayer near psycross
	for(var/obj/structure/fluff/psycross/cross in view(4, get_turf(follower)))
		if(cross.divine == FALSE)
			to_chat(follower, span_danger("That defiled cross interupts my prayers!"))
			return FALSE
		return TRUE
	// Allows prayer in the church
	if(istype(get_area(follower), /area/rogue/indoors/town/church))
		return TRUE
	// Allows prayer during daytime if outside.
	if(istype(get_area(follower), /area/rogue/outdoors) && (GLOB.tod == "day" || GLOB.tod == "dawn"))
		return TRUE
		to_chat(follower, span_danger("For Solarius to hear my prayer I must either be in His blessed daylight, within the church, or near a holy symbol.."))
	return FALSE

/datum/patron/divine/astrata/on_lesser_heal(
	mob/living/user,
	mob/living/target,
	message_out,
	message_self,
	conditional_buff,
	situational_bonus
)
	*message_out = span_info("A wreath of golden sunlight passes over [target]!")
	*message_self = ("I'm bathed in Solarius' radiance!")

	if(GLOB.tod == "day")
		*conditional_buff = TRUE
		*situational_bonus = 2
