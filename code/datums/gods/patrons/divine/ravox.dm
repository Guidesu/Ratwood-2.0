/datum/patron/divine/ravox
	name = "Valorax"
	domain = "War, Battle, Honor, Righteous Fury"
	desc = "The Battleborn lost His left arm in single combat with a Titan during the Godswar. The wound never healed, eternally reminding Him that even gods can fall. He serves as Solarius' champion, ensuring that justice through strength does not become tyranny through cruelty. His followers seek glory in honorable combat, knowing that in battle, the worthy prove themselves. The Battleborn judges not by words, but by deeds in the crucible of war."
	worshippers = "Warriors, Mercenaries, Knights, Honorbound"
	mob_traits = list(TRAIT_SHARPER_BLADES)
	miracles = list(/obj/effect/proc_holder/spell/targeted/touch/orison			= CLERIC_ORI,
					/obj/effect/proc_holder/spell/invoked/tug_of_war			= CLERIC_T0,
					/obj/effect/proc_holder/spell/invoked/lesser_heal 			= CLERIC_T1,
					/obj/effect/proc_holder/spell/invoked/blood_heal			= CLERIC_T1,
					/obj/effect/proc_holder/spell/self/divine_strike			= CLERIC_T1,
					/obj/effect/proc_holder/spell/self/call_to_arms				= CLERIC_T2,
					/obj/effect/proc_holder/spell/invoked/challenge				= CLERIC_T2,
					/obj/effect/proc_holder/spell/invoked/persistence			= CLERIC_T3,
					/obj/effect/proc_holder/spell/invoked/resurrect/ravox		= CLERIC_T4,
	)
	confess_lines = list(
		"VALORAX DEMANDS HONOR!",
		"THROUGH STRIFE, GLORY!",
		"I FEAR NOT THE BLADE!",
	)
	storyteller = /datum/storyteller/ravox
	COOLDOWN_DECLARE(lesser_heal_buff_cooldown)

// Near a knight statue, cross, or within the church
/datum/patron/divine/ravox/can_pray(mob/living/follower)
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
	// Allows prayer near any knight statue and its subtypes.
	for(var/obj/structure/fluff/statue/knight/K in view(4, get_turf(follower)))
		return TRUE
		to_chat(follower, span_danger("For Valorax to hear my prayer I must either pray within the church, near a holy symbol, or near a monument to fallen warriors.."))
	return FALSE

/datum/patron/divine/ravox/on_lesser_heal(
	mob/living/user,
	mob/living/target,
	message_out,
	message_self,
	conditional_buff,
	situational_bonus
)
	*message_out = span_info("An aura of battle-fury rises around [target]!")
	*message_self = span_notice("Valorax fills me with the will to fight on!")

	var/bonus = 0

	if(istype(target.rmb_intent, /datum/rmb_intent/strong))
		bonus++

	if(istype(target.get_active_held_item(), /obj/item/rogueweapon))
		bonus += 0.5

	if(target == user && target.blood_volume <= BLOOD_VOLUME_OKAY && COOLDOWN_FINISHED(src, lesser_heal_buff_cooldown))
		user.emote("warcry")
		user.blood_volume += BLOOD_VOLUME_SURVIVE / 3
		bonus += 2
		COOLDOWN_START(src, lesser_heal_buff_cooldown, 30 SECONDS)

	if(!bonus)
		return

	*conditional_buff = TRUE
	*situational_bonus = bonus
