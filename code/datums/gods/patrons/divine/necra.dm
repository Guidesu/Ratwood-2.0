/datum/patron/divine/necra
	name = "Mortara"
	domain = "Death, The Afterlife, Passage, Rebirth"
	desc = "The Pale Shepherdess guides all souls to the realm of the dead, Her duty unchanged since before the Godswar. While other gods were wounded in body, Mortara bore a wound of the spirit - She now remembers every soul that perished in the Cataclysm, an endless litany of names that drives Her to solitude. Her followers revere the natural cycle of death and rebirth, seeing resurrection magic as a perversion that traps souls in a broken world. Only through death can one escape the coming Final Winter."
	worshippers = "Gravediggers, Morticians, Death Knights, Mourners"
	mob_traits = list(TRAIT_SOUL_EXAMINE, TRAIT_NOSTINK)	//No stink is generic but they deal with dead bodies so.. makes sense, I suppose?
	miracles = list(/obj/effect/proc_holder/spell/targeted/touch/orison				= CLERIC_ORI,
					/obj/effect/proc_holder/spell/invoked/necras_sight				= CLERIC_T0,
					/obj/effect/proc_holder/spell/targeted/locate_dead				= CLERIC_T0,
					/obj/effect/proc_holder/spell/invoked/lesser_heal				= CLERIC_T1,
					/obj/effect/proc_holder/spell/invoked/blood_heal				= CLERIC_T1,
					/obj/effect/proc_holder/spell/invoked/avert						= CLERIC_T1,
					/obj/effect/proc_holder/spell/invoked/speakwithdead				= CLERIC_T1,
					/obj/effect/proc_holder/spell/targeted/abrogation				= CLERIC_T2,
					/obj/effect/proc_holder/spell/self/necra_spirits				= CLERIC_T3,
					/obj/effect/proc_holder/spell/invoked/deaths_door				= CLERIC_T3,//This was bad enough at T1. No, thanks. Cool as it is.
					/obj/effect/proc_holder/spell/targeted/churn					= CLERIC_T4,//Priest/Acolytes only. Thanks.
	)
	confess_lines = list(
		"ALL SOULS FIND THEIR WAY TO MORTARA!",
		"THE SHEPHERDESS GUIDES US HOME!",
		"I FEAR NOT DEATH!",
	)
	storyteller = /datum/storyteller/necra

// Near a grave, cross, or within the church
/datum/patron/divine/necra/can_pray(mob/living/follower)
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
	// Allows prayer near a grave.
	for(var/obj/structure/closet/dirthole/grave/G in view(4, get_turf(follower)))
		return TRUE
		to_chat(follower, span_danger("For Mortara to hear my prayer I must either pray within the church, near a holy symbol, or near a grave where all souls find their rest.."))
	return FALSE

/datum/patron/divine/necra/on_lesser_heal(
	mob/living/user,
	mob/living/target,
	message_out,
	message_self,
	conditional_buff,
	situational_bonus
)
	*message_out = span_info("A sense of peaceful inevitability radiates from [target]!")
	*message_self = span_notice("Mortara turns Her gaze from me... for now!")

	if(iscarbon(target))
		var/mob/living/carbon/carbon = target
		if(carbon.health <= (carbon.maxHealth * 0.25))
			*conditional_buff = TRUE
			*situational_bonus = 2.5
