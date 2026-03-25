/datum/patron/divine/malum
	name = "Forgemar"
	domain = "Craft, Fire, Creation, Ingenuity"
	desc = "The Lord of the Forge lost His left hand during the Godswar while attempting to reforge one of the Shattered Spheres. The injury never healed, leaving Him with a blackened stump that still smolders with divine flame. He teaches that tools have no morality - the well-oiled guillotine and the well-sharpened axe are merely instruments of their wielder's will. His followers believe that in a dying world, only through tireless craft can mortals build something that will survive the coming Final Winter."
	worshippers = "Smiths, Miners, Engineers, Dwarves, Craftsmen"
	mob_traits = list(TRAIT_FORGEBLESSED, TRAIT_BETTER_SLEEP)
	miracles = list(/obj/effect/proc_holder/spell/targeted/touch/orison			= CLERIC_ORI,
					/obj/effect/proc_holder/spell/invoked/malum_flame_rogue 	= CLERIC_T0,
					/obj/effect/proc_holder/spell/invoked/lesser_heal 			= CLERIC_T1,
					/obj/effect/proc_holder/spell/invoked/blood_heal			= CLERIC_T1,
					/obj/effect/proc_holder/spell/invoked/conjure_tool			= CLERIC_T1,
					/obj/effect/proc_holder/spell/invoked/vigorousexchange		= CLERIC_T1,
					/obj/effect/proc_holder/spell/invoked/heatmetal				= CLERIC_T2,
					/obj/effect/proc_holder/spell/invoked/hammerfall			= CLERIC_T3,
					/obj/effect/proc_holder/spell/invoked/craftercovenant		= CLERIC_T4,
					/obj/effect/proc_holder/spell/invoked/resurrect/malum		= CLERIC_T4,
	)
	confess_lines = list(
		"FORGEMAR IS MY MUSE!",
		"TRUE VALUE IS IN THE TOIL!",
		"I AM AN INSTRUMENT OF CREATION!",
	)

	storyteller = /datum/storyteller/malum

// Near a smelter, hearth, cross, within the smithy, or within the church
/datum/patron/divine/malum/can_pray(mob/living/follower)
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
	// Allows prayer in the smith's building.
	if(istype(get_area(follower), /area/rogue/indoors/town/dwarfin))
		return TRUE
	// Allows prayer near hearths.
	for(var/obj/machinery/light/rogue/hearth/H in view(4, get_turf(follower)))
		return TRUE
	// Allows prayer near smelters.
	for(var/obj/machinery/light/rogue/smelter/H in view(4, get_turf(follower)))
		return TRUE
		to_chat(follower, span_danger("For Forgemar to hear my prayer I must either pray within the church, the smithy's workshop, near a holy symbol, near a smelter, or hearth to bask in His glory.."))
	return FALSE

/datum/patron/divine/malum/on_lesser_heal(
	mob/living/user,
	mob/living/target,
	message_out,
	message_self,
	conditional_buff,
	situational_bonus
)
	*message_out = span_info("A tempering heat is discharged out of [target]!")
	*message_self = span_info("I feel the heat of Forgemar's anvil soothing my pains!")

	var/list/firey_stuff = list(/obj/machinery/light/rogue/torchholder, /obj/machinery/light/rogue/campfire, /obj/machinery/light/rogue/hearth, /obj/machinery/light/rogue/campfire/fireplace, /obj/machinery/light/rogue/candle, /obj/machinery/light/rogue/forge)
	var/bonus = 0

	// extra healing for every source of fire/light near us
	for(var/obj/obj in oview(5, user))
		if(!(obj.type in firey_stuff))
			continue

		bonus = min(bonus + 0.5, 2.5)

	if(!bonus)
		return

	*situational_bonus = bonus
	*conditional_buff = TRUE
