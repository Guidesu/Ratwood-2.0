/datum/patron/divine/xylix
	name = "Fortis"
	domain = "Luck, Trickery, Freedom, Fate, Chance"
	desc = "The Laughing Gambler lost something during the Godswar - but no one, not even Fortis Himself, remembers what. Some say it was His true name, others claim it was His purpose. What remains is a god obsessed with randomness and fortune, believing that in a world broken by fate, only chaos can set mortals free. He created the Fluvian race with the gift of unpredictable fate, and delights in pulling pranks that reshape destiny itself. His followers see freedom as absolute, despising slavery and predetermined paths."
	worshippers = "Gamblers, Bards, Artists, The Silver-Tongued, Fluvians"
	mob_traits = list(TRAIT_XYLIX)
	miracles = list(/obj/effect/proc_holder/spell/targeted/touch/orison				= CLERIC_ORI,
					/obj/effect/proc_holder/spell/self/xylixslip					= CLERIC_T0,
					/obj/effect/proc_holder/spell/invoked/xylixlian_luck        	= CLERIC_T1,
					/obj/effect/proc_holder/spell/invoked/lesser_heal 				= CLERIC_T1,
					/obj/effect/proc_holder/spell/invoked/projectile/fetch/miracle 	= CLERIC_T1,
					/obj/effect/proc_holder/spell/invoked/projectile/repel/miracle 	= CLERIC_T1,
					/obj/effect/proc_holder/spell/invoked/mockery					= CLERIC_T1,
					/obj/effect/proc_holder/spell/invoked/blood_heal				= CLERIC_T2,
					/obj/effect/proc_holder/spell/invoked/mastersillusion			= CLERIC_T2,
					/obj/effect/proc_holder/spell/invoked/wound_heal				= CLERIC_T4,
	)
	confess_lines = list(
		"SOLARIUS IS MY LIGHT!",
		"LUNETH ILLUMINATES THE DARK!",
		"SILVANUS PROVIDES!",
		"TEMPESTIA COMMANDS THE WAVES!",
		"VALORAX DEMANDS HONOR!",
		"ALL SOULS FIND THEIR WAY TO MORTARA!",
		"HAHAHAHA! AHAHAHA! HAHAHAHA!",
		"VERDAN SOOTHES ALL ILLS!",
		"FORGEMAR IS MY MUSE!",
		"AELIS BRINGS US TOGETHER!",
		"LONG LIVE AETHROS!",
		"KHARGATH IS THE BEAST I WORSHIP!",
		"AURON IS MY LORD!",
		"LUXARA IS MY JOY!",
		"REBUKE THE HERETICAL- PSYDON ENDURES!",
	)
	storyteller = /datum/storyteller/xylix

// Near a gambling machine, cross, or within the church
/datum/patron/divine/xylix/can_pray(mob/living/follower)
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
	// Allows prayer near gambling machines.
	for(var/obj/structure/roguemachine/lottery_roguetown/L in view(4, get_turf(follower)))
		return TRUE
		to_chat(follower, span_danger("For Fortis to hear my prayer I must either pray within the church, near a holy symbol, or near a machine of fortune blessed by the grand gambler.."))
	return FALSE

/datum/patron/divine/xylix/on_lesser_heal(
	mob/living/user,
	mob/living/target,
	message_out,
	message_self,
	conditional_buff,
	situational_bonus
)
	*message_out = span_info("A fugue seems to manifest briefly across [target]!")
	*message_self = span_notice("My wounds vanish as if they had never been there - Fortis smiles upon me!")

	if(prob(50))
		*conditional_buff = TRUE
		*situational_bonus = rand(1, 2.5)
