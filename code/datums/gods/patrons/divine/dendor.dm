/datum/patron/divine/dendor
	name = "Silvanus"
	domain = "Plants, Animals, Nature, Agriculture, The Wild"
	desc = "The Treefather was driven to the edge of madness watching His forests burn during the Godswar. What chaos-corruption could not destroy, the battling gods trampled underfoot. Now He stands eternal vigil over what wilderness remains, blessing harvests while His maddened beasts hunt those who would despoil the green places. The druids claim He speaks through the trees, warning of the Final Winter's approach."
	worshippers = "Druids, Beasts, Madmen, Farmers, Elves, Wildkin"
	mob_traits = list(TRAIT_KNEESTINGER_IMMUNITY, TRAIT_LEECHIMMUNE)
	miracles = list(/obj/effect/proc_holder/spell/targeted/touch/orison			= CLERIC_ORI,
					/obj/effect/proc_holder/spell/invoked/spiderspeak 			= CLERIC_T0,
					/obj/effect/proc_holder/spell/targeted/blesscrop			= CLERIC_T0,
					/obj/effect/proc_holder/spell/invoked/lesser_heal 			= CLERIC_T1,
					/obj/effect/proc_holder/spell/invoked/blood_heal			= CLERIC_T1,
					/obj/effect/proc_holder/spell/self/wildshape				= CLERIC_T2,
					/obj/effect/proc_holder/spell/targeted/beasttame			= CLERIC_T2,
					/obj/effect/proc_holder/spell/targeted/conjure_glowshroom	= CLERIC_T3,
					/obj/effect/proc_holder/spell/targeted/conjure_vines 		= CLERIC_T3,
					/obj/effect/proc_holder/spell/self/howl/call_of_the_moon	= CLERIC_T4,
					/obj/effect/proc_holder/spell/invoked/resurrect/dendor		= CLERIC_T4,
	)
	confess_lines = list(
		"SILVANUS PROVIDES!",
		"THE TREEFATHER ENDURES!",
		"I ANSWER THE CALL OF THE WILD!",
	)
	storyteller = /datum/storyteller/dendor

// In grove, bog, cross, or ritual chalk
// Yes, he is NOT calling the master cus he's unique. Whole bog is his prayer zone. Druids exist for a reason instead of in the church.
/datum/patron/divine/dendor/can_pray(mob/living/follower)
	. = ..()
	// Allows prayer near psycross
	for(var/obj/structure/fluff/psycross/cross in view(4, get_turf(follower)))
		if(cross.divine == FALSE)
			to_chat(follower, span_danger("That defiled cross interupts my prayers!"))
			return FALSE
		return TRUE
	// Allows prayer in the druid tower + houses in the forest
	if(istype(get_area(follower), /area/rogue/indoors/shelter/woods))
		return TRUE
	// Allows prayer in outdoors wilderness, such as bog
	if(istype(get_area(follower), /area/rogue/outdoors/rtfield))
		return TRUE
	for(var/obj/structure/flora/roguetree/wise in view(4, get_turf(follower)))
		return TRUE
		to_chat(follower, span_danger("I must either be in Silvanus' wilds, the Grove, near a wise tree, or near a Pantheon symbol for the Treefather to hear my prayers..."))
	return FALSE

/datum/patron/divine/dendor/on_lesser_heal(
	mob/living/user,
	mob/living/target,
	message_out,
	message_self,
	conditional_buff,
	situational_bonus
)
	*message_out = span_info("A rush of primal verdant energy spirals about [target]!")
	*message_self = span_notice("I'm infused with Silvanus' wild power!")

	var/list/natural_stuff = list(/obj/structure/flora/roguegrass, /obj/structure/flora/roguetree, /obj/structure/flora/rogueshroom, /obj/structure/soil, /obj/structure/flora/newtree, /obj/structure/flora/tree, /obj/structure/glowshroom)
	var/bonus = 0

	// the more natural stuff around US, the more we heal
	for (var/obj/obj in oview(5, user))
		if(!(obj.type in natural_stuff))
			continue

		bonus = min(bonus + 0.1, 2)

	for(var/obj/structure/flora/roguetree/wise/tree in oview(5, user))
		bonus += 1.5

	if(!bonus)
		return

	*conditional_buff = TRUE
	*situational_bonus = bonus
