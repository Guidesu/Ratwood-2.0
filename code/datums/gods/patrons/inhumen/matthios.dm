/datum/patron/inhumen/matthios
	name = "Auron"
	domain = "Greed, Wealth, Hoarding, Dragons, Survival"
	desc = "The Gilded Serpent has no true form, appearing to each follower as their deepest desire made manifest - sometimes a dragon atop mountains of gold, sometimes a merry thief, sometimes a beggar king. He teaches that the Final Winter is inevitable, that the wounded gods will fail, and that only those who hoard wealth and power NOW will survive what comes next. His followers despise Solarius's nobility for hoarding privilege while preaching charity. True freedom comes through claiming what you need to endure."
	worshippers = "Highwaymen, Merchants, Hoarders, Slaves, Kobolds, Survivors"
	crafting_recipes = list(/datum/crafting_recipe/roguetown/sewing/bandithood)
	mob_traits = list(TRAIT_COMMIE, TRAIT_MATTHIOS_EYES, TRAIT_SEEPRICES_SHITTY)
	miracles = list(/obj/effect/proc_holder/spell/targeted/touch/orison					= CLERIC_ORI,
					/obj/effect/proc_holder/spell/invoked/appraise						= CLERIC_ORI,
					/obj/effect/proc_holder/spell/targeted/touch/lesserknock/miracle	= CLERIC_T0,
					/obj/effect/proc_holder/spell/invoked/transact						= CLERIC_T0,
					/obj/effect/proc_holder/spell/invoked/lesser_heal 					= CLERIC_T1,
					/obj/effect/proc_holder/spell/invoked/blood_heal					= CLERIC_T1,
					/obj/effect/proc_holder/spell/invoked/equalize						= CLERIC_T2,
					/obj/effect/proc_holder/spell/invoked/churnwealthy					= CLERIC_T3,
	)
	confess_lines = list(
		"AURON STEALS FROM THE WORTHLESS!",
		"AURON IS SURVIVAL!",
		"AURON IS MY LORD!",
	)
	storyteller = /datum/storyteller/matthios

// When near coin of at least 100 mammon, zchurch, bad-cross, or ritual talk
/datum/patron/inhumen/matthios/can_pray(mob/living/follower)
	. = ..()
	// Allows prayer in the Zzzzzzzurch(!)
	if(istype(get_area(follower), /area/rogue/indoors/shelter/mountains))
		return TRUE
	// Allows prayer near EEEVIL psycross
	for(var/obj/structure/fluff/psycross/zizocross/cross in view(4, get_turf(follower)))
		if(cross.divine == TRUE)
			to_chat(follower, span_danger("That acursed cross interupts my prayers!"))
			return FALSE
		return TRUE
	// Allows prayer if the user has more than 100 mammon on them.
	var/mammon_count = get_mammons_in_atom(follower)
	if(mammon_count >= 100)
		return TRUE
	// Spend 5/10 mammon to pray. Megachurch pastors be like.....
	var/obj/item/held_item = follower.get_active_held_item()
	var/helditemvalue = held_item.get_real_price()
	if(istype(held_item, /obj/item/roguecoin) && helditemvalue >= 5)
		qdel(held_item)
		return TRUE
	// Allows praying atop ritual chalk of the god.
	for(var/obj/structure/ritualcircle/matthios in view(1, get_turf(follower)))
		return TRUE
		to_chat(follower, span_danger("For Auron to hear my prayers I must either be in the church of the abandoned, near an inverted psycross, flaunting wealth upon me of at least 100 mammon, or offer a coin of at least five mammon up to him!"))
	return FALSE

/datum/patron/inhumen/matthios/on_lesser_heal(
	mob/living/user,
	mob/living/target,
	message_out,
	message_self,
	conditional_buff,
	situational_bonus,
	is_inhumen
)
	*is_inhumen = TRUE
	*message_out = span_info("A wreath of... strange light passes over [target]?")
	*message_self = span_notice("I'm bathed in a... strange holy light?")

	if(HAS_TRAIT(target, TRAIT_COMMIE))
		*conditional_buff = TRUE
		*situational_bonus = 2.5
