// Virtues that let you unlock crafter role
/datum/virtue/utility/blacksmith
	name = "Blacksmith's Apprentice"
	desc = "In my youth, I worked under a skilled blacksmith, honing my skills with an anvil."
	added_traits = list(TRAIT_SMITHING_EXPERT)
	added_skills = list(list(/datum/skill/craft/crafting, 2, 2),
						list(/datum/skill/craft/weaponsmithing, 2, 2),
						list(/datum/skill/craft/armorsmithing, 2, 2),
						list(/datum/skill/craft/blacksmithing, 2, 2),
						list(/datum/skill/craft/smelting, 2, 2)
	)

/datum/virtue/utility/tailor
	name = "Tailor's Apprentice"
	desc = "In my youth, I worked under a skilled tailor, studying fabric and design."
	added_traits = list(TRAIT_SEWING_EXPERT)
	added_skills = list(list(/datum/skill/craft/crafting, 2, 2),
						list(/datum/skill/labor/butchering, 2, 2),
						list(/datum/skill/craft/sewing, 2, 2),
						list(/datum/skill/craft/tanning, 2, 2),
	)
	added_stashed_items = list(
		"Needle" = /obj/item/needle,
		"Scissors" = /obj/item/rogueweapon/huntingknife/scissors
	)

/datum/virtue/utility/physician
	name = "Physician's Apprentice"
	desc = "In my youth, I worked under a skilled physician, studying medicine and alchemy."
	added_traits = list(TRAIT_MEDICINE_EXPERT, TRAIT_ALCHEMY_EXPERT)
	added_stashed_items = list("Medicine Pouch" = /obj/item/storage/belt/rogue/pouch/medicine)
	added_skills = list(list(/datum/skill/craft/crafting, 2, 2),
						list(/datum/skill/craft/alchemy, 2, 2),
						list(/datum/skill/misc/medicine, 2, 2)
	)

/datum/virtue/utility/physician/apply_to_human(mob/living/carbon/human/recipient)
	if(!recipient.mind?.has_spell(/obj/effect/proc_holder/spell/invoked/diagnose/secular))
		recipient.mind?.AddSpell(new /obj/effect/proc_holder/spell/invoked/diagnose/secular)


/datum/virtue/utility/hunter
	name = "Hunter's Apprentice"
	desc = "In my youth, I trained under a skilled hunter, learning how to butcher animals and work with leather/hide."
	added_traits = list(TRAIT_SURVIVAL_EXPERT)
	added_skills = list(list(/datum/skill/craft/crafting, 2, 2),
						list(/datum/skill/craft/traps, 2, 2),
						list(/datum/skill/labor/butchering, 2, 2),
						list(/datum/skill/craft/sewing, 2, 2),
						list(/datum/skill/craft/tanning, 2, 2),
						list(/datum/skill/misc/tracking, 2, 2)
	)

/datum/virtue/utility/artificer
	name = "Artificer's Apprentice"
	desc = "In my youth, I worked under a skilled artificer, studying construction and engineering."
	added_traits = list(TRAIT_SMITHING_EXPERT)
	added_skills = list(list(/datum/skill/craft/crafting, 2, 2),
						list(/datum/skill/craft/carpentry, 2, 2),
						list(/datum/skill/craft/masonry, 2, 2),
						list(/datum/skill/craft/engineering, 2, 2),
						list(/datum/skill/craft/smelting, 2, 2),
						list(/datum/skill/craft/ceramics, 2, 2)
	)
	added_stashed_items = list(
		"Hammer" = /obj/item/rogueweapon/hammer/wood,
		"Chisel" = /obj/item/rogueweapon/chisel,
		"Hand Saw" = /obj/item/rogueweapon/handsaw,
		"Blowing Pipe" = /obj/item/rogueweapon/blowrod
	)

/datum/virtue/utility/mining
	name = "Miner's Apprentice"
	added_traits = list(TRAIT_SMITHING_EXPERT) // Not sure whether smithing or homestead but given mining goods goes into smithing this fits better?
	desc = "The dark shafts, the damp smells of ichor and the laboring hours are no stranger to me. I keep my pickaxe and lamptern close, and have been taught how to mine well."
	added_stashed_items = list(
		"Steel Pickaxe" = /obj/item/rogueweapon/pick/steel,
		"Lamptern" = /obj/item/flashlight/flare/torch/lantern,
		"Ore Bag" = /obj/item/storage/hip/orestore/bronze,
	)
	added_skills = list(list(/datum/skill/labor/mining, 3, 6))



// Apprentice-level virtues - provide broad skill sets without traits or items
// Max skill level is Apprentice (level 2), allowing varied work without full progression

/datum/virtue/utility/survivalist_novice
	name = "Novice Survivalist"
	desc = "I've lived in the wilds and learned to survive off the land. I can hunt, track, fish, trap, and butcher game - all the skills needed to live beyond civilization's walls."
	added_skills = list(
		list(/datum/skill/misc/tracking, 1, 2),
		list(/datum/skill/labor/butchering, 1, 2),
		list(/datum/skill/craft/tanning, 1, 2),
		list(/datum/skill/craft/traps, 1, 2),
		list(/datum/skill/combat/staves, 1, 2),
		list(/datum/skill/combat/slings, 1, 2),
		list(/datum/skill/craft/crafting, 1, 2),
		list(/datum/skill/craft/cooking, 1, 2),
		list(/datum/skill/labor/lumberjacking, 1, 2),
		list(/datum/skill/misc/climbing, 1, 2),
		list(/datum/skill/misc/swimming, 1, 2),
		list(/datum/skill/misc/sneaking, 1, 2),
		list(/datum/skill/misc/medicine, 1, 1)
	)

/datum/virtue/utility/homesteader_novice
	name = "Novice Homesteader"
	desc = "I know how to maintain a homestead - farming the land, cooking meals, chopping wood, and all the daily labors needed to be self-sufficient."
	added_skills = list(
		list(/datum/skill/labor/farming, 1, 2),
		list(/datum/skill/craft/cooking, 1, 2),
		list(/datum/skill/labor/lumberjacking, 1, 2),
		list(/datum/skill/misc/lockpicking, 1, 2),
		list(/datum/skill/misc/climbing, 1, 2),
		list(/datum/skill/misc/athletics, 1, 2),
		list(/datum/skill/labor/fishing, 1, 2),
		list(/datum/skill/craft/masonry, 1, 2),
		list(/datum/skill/craft/carpentry, 1, 2),
		list(/datum/skill/craft/crafting, 1, 2),
		list(/datum/skill/combat/maces, 1, 2),
		list(/datum/skill/combat/axes, 1, 2)
	)

/datum/virtue/utility/artisan_novice
	name = "Novice Artisan"
	desc = "I've learned the fundamentals of crafting - working with metal, fabric, and clay. I'm a jack of all trades in the workshop, though master of none."
	added_skills = list(
		list(/datum/skill/craft/crafting, 1, 2),
		list(/datum/skill/craft/blacksmithing, 1, 2),
		list(/datum/skill/craft/sewing, 1, 2),
		list(/datum/skill/craft/smelting, 1, 2),
		list(/datum/skill/craft/weaponsmithing, 1, 2),
		list(/datum/skill/craft/armorsmithing, 1, 2),
		list(/datum/skill/combat/knives, 1, 2),
		list(/datum/skill/craft/ceramics, 1, 2),
		list(/datum/skill/craft/engineering, 1, 2)
	)

/datum/virtue/utility/healer_novice
	name = "Novice Healer"
	desc = "I've studied the healing arts - tending wounds, brewing remedies, and understanding the basics of medicine and alchemy."
	added_skills = list(
		list(/datum/skill/misc/medicine, 1, 2),
		list(/datum/skill/craft/alchemy, 1, 2),
		list(/datum/skill/misc/reading, 1, 2),
		list(/datum/skill/craft/crafting, 1, 2),
		list(/datum/skill/craft/sewing, 1, 2),
		list(/datum/skill/craft/cooking, 1, 2),
		list(/datum/skill/combat/knives, 1, 2)
	)



/datum/virtue/utility/larcenous
	name = "Larcenous"
	desc = "Whether it was asked of you, or by a calling for the rush deep within your hollow heart, you seek things that don't belong you. You know how to work a lock, and have stashed a ring of them, for just the occasion."
	added_stashed_items = list("Lockpick Ring" = /obj/item/lockpickring/mundane)
	added_skills = list(list(/datum/skill/misc/lockpicking, 3, 6))

/datum/virtue/utility/granary
	name = "Cunning Provisioner"
	added_traits = list(TRAIT_HOMESTEAD_EXPERT)
	desc = "You've worked in or around the docks enough to steal away a sack of supplies that no one would surely miss, just in case. You've picked up on some cooking and fishing tips in your spare time, as well."
	added_stashed_items = list("Bag of Food" = /obj/item/storage/roguebag/food)
	added_skills = list(list(/datum/skill/craft/cooking, 3, 6),
						list(/datum/skill/labor/fishing, 2, 6))

/datum/virtue/utility/forester
	name = "Forester"
	added_traits = list(TRAIT_HOMESTEAD_EXPERT)
	desc = "The forest is your home, or at least, it used to be. You always long to return and roam free once again, and you have not forgotten your knowledge on how to be self sufficient."
	added_stashed_items = list("Trusty hoe" = /obj/item/rogueweapon/hoe)
	added_skills = list(list(/datum/skill/craft/cooking, 2, 2),
						list(/datum/skill/misc/athletics, 2, 2),
						list(/datum/skill/labor/farming, 2, 2),
						list(/datum/skill/labor/fishing, 2, 2),
						list(/datum/skill/labor/lumberjacking, 2, 2)
	)

/datum/virtue/utility/homesteader
	name = "Pilgrim (-3 TRI)"
	added_traits = list(TRAIT_HOMESTEAD_EXPERT)
	desc= "As they say, 'hearth is where the heart is'. You are intimately familiar with the labors of lyfe, and have stowed away everything necessary to start anew: a hunting dagger, your trusty hoe, and a sack of assorted supplies."
	triumph_cost = 3
	added_stashed_items = list(
		"Hoe" = /obj/item/rogueweapon/hoe,
		"Bag of Food" = /obj/item/storage/roguebag/food,
		"Hunting Knife" = /obj/item/rogueweapon/huntingknife
	)
	added_skills = list(list(/datum/skill/craft/cooking, 3, 3),
						list(/datum/skill/misc/athletics, 2, 2),
						list(/datum/skill/labor/farming, 3, 3),
						list(/datum/skill/labor/fishing, 3, 3),
						list(/datum/skill/labor/lumberjacking, 2, 2),
						list(/datum/skill/combat/knives, 2, 2)
	)
