/datum/patron/divine/pestra
	name = "Verdan"
	domain = "Medicine, Pestilence, Decay, Transformation"
	desc = "The Plaguemother was born from the rot and decay that festered in the Cataclysm's wake. Unlike the wounded gods, She is entirely new - a divine manifestation of disease given purpose. She teaches that decay is merely transformation, that rot nourishes new growth, and that illness purges weakness. Her followers are obsessed with the cycle of death and renewal, seeing Her plagues not as punishment but as gifts that strengthen survivors. Through suffering comes evolution."
	worshippers = "The Sick, Chirurgeons, Apothecaries, Plague Doctors"
	mob_traits = list(TRAIT_EMPATH, TRAIT_ROT_EATER)
	miracles = list(/obj/effect/proc_holder/spell/targeted/touch/orison			= CLERIC_ORI,
					/obj/effect/proc_holder/spell/invoked/diagnose				= CLERIC_ORI,
					/obj/effect/proc_holder/spell/invoked/pestra_leech			= CLERIC_T0,
					/obj/effect/proc_holder/spell/invoked/lesser_heal 			= CLERIC_T1,
					/obj/effect/proc_holder/spell/invoked/blood_heal			= CLERIC_T1,
					/obj/effect/proc_holder/spell/invoked/infestation			= CLERIC_T1,
					/obj/effect/proc_holder/spell/invoked/pestilent_blade		= CLERIC_T2,
					/obj/effect/proc_holder/spell/invoked/pestra_heal			= CLERIC_T2,
					/obj/effect/proc_holder/spell/invoked/attach_bodypart		= CLERIC_T2,
					/obj/effect/proc_holder/spell/invoked/heal					= CLERIC_T3,
					/obj/effect/proc_holder/spell/invoked/cure_rot				= CLERIC_T3,
					/obj/effect/proc_holder/spell/invoked/resurrect/pestra		= CLERIC_T4,
	)
	confess_lines = list(
		"VERDAN SOOTHES ALL ILLS!",
		"DECAY IS A CONTINUATION OF LIFE!",
		"MY AFFLICTION IS MY TESTAMENT!",
	)
	storyteller = /datum/storyteller/pestra

// Near a well, cross, within the physicians, or within the church
/datum/patron/divine/pesta/can_pray(mob/living/follower)
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
	// Allows prayer in the appothocary's building.
	if(istype(get_area(follower), /area/rogue/indoors/town/physician))
		return TRUE
	// Allows prayer near wells. Weird one, but makes sense for health and disease. Miasma, water, etc.
	for(var/obj/structure/well/W in view(4, get_turf(follower)))
		return TRUE
		to_chat(follower, span_danger("For Verdan to hear my prayer I must either pray within the church, physician's building, near a holy symbol, or near a well to observe the full cycle of transformation.."))
	return FALSE

/datum/patron/divine/pestra/on_lesser_heal(
	mob/living/user,
	mob/living/target,
	message_out,
	message_self,
	conditional_buff,
	situational_bonus
)
	*message_out = span_info("An aura of clinical care encompasses [target]!")
	*message_self = span_notice("I'm sewn back together by Verdan's sacred medicine!")

	target.adjustToxLoss(-*situational_bonus)
	target.blood_volume += BLOOD_VOLUME_SURVIVE / 3
