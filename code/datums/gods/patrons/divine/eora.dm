/datum/patron/divine/eora
	name = "Aelis"
	domain = "Love, Family, Beauty, Compassion"
	desc = "The Lady of the Hearth had Her voice stolen during the Godswar, unable to sing the songs that once kindled love in mortal hearts. Now She blesses unions not through words but through silent acts of devotion and sacrifice. She despises Solarius's rigid marriage laws as chains that bind love into servitude. Her followers are oft promiscuous, believing that love in all its forms - passionate, familial, fleeting - is the only beauty left in a broken world. If the Final Winter comes, let mortals face it wrapped in each other's warmth."
	worshippers = "Lovers, Doting Parents, Bards, Hopeless Romantics"
	mob_traits = list(TRAIT_EMPATH, TRAIT_EXTEROCEPTION)
	miracles = list(/obj/effect/proc_holder/spell/targeted/touch/orison			= CLERIC_ORI,
					/obj/effect/proc_holder/spell/invoked/eora_blessing			= CLERIC_T0,
					/obj/effect/proc_holder/spell/invoked/lesser_heal 			= CLERIC_T1,
					/obj/effect/proc_holder/spell/invoked/blood_heal			= CLERIC_T1,
					/obj/effect/proc_holder/spell/invoked/bless_food            = CLERIC_T1,
					/obj/effect/proc_holder/spell/invoked/bud					= CLERIC_T1,
					/obj/effect/proc_holder/spell/invoked/heartweave			= CLERIC_T2,
					/obj/effect/proc_holder/spell/invoked/eoracurse				= CLERIC_T3,
					/obj/effect/proc_holder/spell/invoked/pomegranate			= CLERIC_T4,
					/obj/effect/proc_holder/spell/invoked/resurrect/eora		= CLERIC_T4,
	)
	confess_lines = list(
		"AELIS BRINGS US TOGETHER!",
		"HER BEAUTY IS EVEN IN THIS TORMENT!",
		"I LOVE YOU, EVEN AS YOU TRESPASS AGAINST ME!",
	)
	traits_tier = list(TRAIT_EORAN_CALM = CLERIC_T0, TRAIT_EORAN_SERENE = CLERIC_T2)
	storyteller = /datum/storyteller/eora

// Near a psycross, inside the church, holding poppy flowers, or has pacifism trait
/datum/patron/divine/eora/can_pray(mob/living/follower)
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
	// Allows Eorans to pray using flowers
	var/obj/item/held_item = follower.get_active_held_item()
	if(istype(held_item, /obj/item/reagent_containers/food/snacks/grown/rogue/poppy))
		qdel(held_item)
		return TRUE
	// Allows player to pray while wearing eoran bud.
	if(HAS_TRAIT(follower, TRAIT_PACIFISM))
		return TRUE
		to_chat(follower, span_danger("For Aelis to hear my prayer I must either pray within the church, near a holy symbol, offering her poppy flowers, or wearing one of her blessed flowers atop my head.."))
	return FALSE

/datum/patron/divine/eora/on_lesser_heal(
	mob/living/user,
	mob/living/target,
	message_out,
	message_self,
	conditional_buff,
	situational_bonus
)
	*message_out = span_info("An emanance of love blossoms around [target]!")
	*message_self = span_notice("I'm filled with the restorative warmth of Aelis's love!")

	var/bonus = 0

	if(HAS_TRAIT(target, TRAIT_PACIFISM))
		bonus += 2.5

	if(HAS_TRAIT(user, TRAIT_PACIFISM))
		bonus += 1.5

	if(!bonus)
		return

	*situational_bonus = bonus
	*conditional_buff = TRUE
