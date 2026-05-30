/datum/aspect/positive/noble_bearing
	listable = TRUE
	name = "Noble Bearing"
	desc = "You can present yourself as someone of noble blood, without inheriting the whole old Nobility heritage."
	category = "Social"
	point_value = 2
	tags = list("noble")
	conflicts = list("disgraced_noble")
	legacy_sources = list(/datum/virtue/utility/noble)

/datum/aspect/positive/legacy_virtue
	listable = TRUE

/datum/aspect/positive/legacy_virtue/New()
	. = ..()
	if(virtue_type)
		var/datum/virtue/virtue_ref = GLOB.virtues?[virtue_type]
		if(!name || name == initial(name))
			name = virtue_ref?.name || name
		if(!desc)
			desc = virtue_ref?.desc || desc
		if(!point_value)
			point_value = virtue_ref?.virtue_cost || 0
		if(!LAZYLEN(legacy_sources))
			legacy_sources = list(virtue_type)
	added_traits = list(TRAIT_NOBLE)

/datum/aspect/positive/heirloom_amulet
	listable = TRUE
	name = "Heirloom Amulet"
	desc = "A small, visible reminder of a better-kept lineage."
	category = "Social"
	point_value = 1
	tags = list("noble")
	legacy_sources = list(/datum/virtue/utility/noble)
	added_stashed_items = list("Heirloom Amulet" = /obj/item/clothing/neck/roguetown/ornateamulet/noble)

/datum/aspect/positive/hefty_coinpurse
	listable = TRUE
	name = "Hefty Coinpurse"
	desc = "You begin with a modest reserve of mammons, separated from social rank."
	category = "Social"
	point_value = 2
	tags = list("noble")
	legacy_sources = list(/datum/virtue/utility/noble)
	added_stashed_items = list("Hefty Coinpurse" = /obj/item/storage/belt/rogue/pouch/coins/virtuepouch)

/datum/aspect/positive/literate_upbringing
	listable = TRUE
	name = "Literate Upbringing"
	desc = "Someone taught you letters before the Vale could beat that habit out of you."
	category = "Social"
	point_value = 1
	tags = list("literacy")
	added_skills = list(/datum/skill/misc/reading = 1)

/datum/aspect/positive/arcane_spark
	listable = TRUE
	name = "Arcyne Spark"
	desc = "A tiny, carefully contained arcyne talent: enough for prestidigitation and a novice's grounding."
	category = "Magicks"
	point_value = 3
	tags = list("magic", "arcane")
	added_skills = list(/datum/skill/magic/arcane = 1)
	legacy_sources = list(/datum/virtue/combat/magical_potential)

/datum/aspect/positive/arcane_spark/apply_post_equipment(mob/living/carbon/human/H)
	. = ..()
	H.mind?.AddSpell(new /obj/effect/proc_holder/spell/targeted/touch/prestidigitation)

/datum/aspect/positive/arcane_spark/get_extra_summary_lines()
	return list("Ability: Prestidigitation")

/datum/aspect/positive/devotional_grounding
	listable = TRUE
	name = "Devotional Grounding"
	desc = "You have learned the first discipline of prayer, but not the full weight of a devoted virtue."
	category = "Magicks"
	point_value = 2
	tags = list("faith")
	added_skills = list(/datum/skill/magic/holy = 1)

/datum/aspect/positive/devotional_token
	listable = TRUE
	name = "Devotional Token"
	desc = "You keep a simple psycross close at hand."
	category = "Magicks"
	point_value = 1
	tags = list("faith")
	added_stashed_items = list("Psycross" = /obj/item/clothing/neck/roguetown/psicross)

/datum/aspect/positive/equestrian_training
	listable = TRUE
	name = "Equestrian Training"
	desc = "You know how to stay in a saddle. This does not grant a mount."
	category = "Physical"
	point_value = 2
	tags = list("riding")
	added_skills = list(/datum/skill/misc/riding = 1)
	added_stashed_items = list("Saddle" = /obj/item/natural/saddle)
	legacy_sources = list(/datum/virtue/utility/riding, /datum/virtue/movement/equestrian)

/datum/aspect/positive/strained_leap
	listable = TRUE
	name = "Strained Leap"
	desc = "A desperate vertical hop: one adjacent tile and one z-level only, exhausting and briefly stunning after landing."
	category = "Physical"
	point_value = 2
	tags = list("leap")
	conflicts = list("high_jump")
	added_traits = list(TRAIT_STRAINED_LEAP)

/datum/aspect/positive/venomous_bite
	listable = TRUE
	name = "Venomous Bite"
	desc = "Your bite carries a chosen mild venom. You can tune the payload, but it stays intentionally restrained."
	category = "Physical"
	point_value = 2
	tags = list("venom", "bite")
	legacy_sources = list(/datum/virtue/utility/wild_born)

/datum/aspect/positive/venomous_bite/is_configurable()
	return TRUE

/datum/aspect/positive/venomous_bite/get_default_config()
	return list(
		"venom" = /datum/reagent/toxin/venom,
		"dose" = 2,
	)

/datum/aspect/positive/venomous_bite/proc/get_allowed_venoms()
	return list(
		"Hunter's Venom" = /datum/reagent/toxin/venom,
		"Itching Histamine" = /datum/reagent/toxin/histamine,
		"Drowsing Sulfonal" = /datum/reagent/toxin/sulfonal,
	)

/datum/aspect/positive/venomous_bite/describe_config(list/config)
	if(!islist(config))
		return "Not configured"
	var/list/allowed = get_allowed_venoms()
	var/venom_name = "Unknown venom"
	for(var/option_name in allowed)
		if(allowed[option_name] == config["venom"])
			venom_name = option_name
			break
	var/dose = clamp(text2num("[config["dose"]]"), 2, 4)
	return "[venom_name], [dose]u per chew"

/datum/aspect/positive/venomous_bite/validate_config(list/config, list/errors)
	var/list/allowed = get_allowed_venoms()
	if(!islist(config))
		LAZYADD(errors, "[name] is missing its configuration.")
		return FALSE
	var/valid_venom = FALSE
	for(var/option_name in allowed)
		if(allowed[option_name] == config["venom"])
			valid_venom = TRUE
			break
	if(!valid_venom)
		LAZYADD(errors, "[name] has an invalid venom selected.")
		return FALSE
	var/dose = text2num("[config["dose"]]")
	if(!(dose in list(2, 4)))
		LAZYADD(errors, "[name] has an invalid venom dose.")
		return FALSE
	return TRUE

/datum/aspect/positive/venomous_bite/configure_for_profile(datum/aspect_profile/profile, datum/preferences/prefs, mob/user)
	var/list/config = profile.ensure_config(type)
	if(!islist(config))
		return FALSE
	var/list/allowed = get_allowed_venoms()
	var/current_venom_name = null
	for(var/option_name in allowed)
		if(allowed[option_name] == config["venom"])
			current_venom_name = option_name
			break
	var/venom_choice = tgui_input_list(user, "Choose the venom your bite will apply. These are intentionally mild options.", "Venomous Bite", allowed, current_venom_name)
	if(!venom_choice)
		return FALSE
	var/list/dose_options = list("Light (2u)" = 2, "Standard (4u)" = 4)
	var/current_dose_name = (config["dose"] == 4) ? "Standard (4u)" : "Light (2u)"
	var/dose_choice = tgui_input_list(user, "Choose the venom amount per successful chew.", "Venomous Bite", dose_options, current_dose_name)
	if(!dose_choice)
		return FALSE
	config["venom"] = allowed[venom_choice]
	config["dose"] = dose_options[dose_choice]
	return TRUE

/datum/aspect/positive/venomous_bite/apply_to_human(mob/living/carbon/human/H, datum/aspect_profile/profile)
	. = ..()
	var/list/config = profile?.get_config(type)
	if(!islist(config))
		return
	H.aspect_venom_type = config["venom"]
	H.aspect_venom_amount = clamp(text2num("[config["dose"]]"), 2, 4)

/datum/aspect/positive/feral_claws
	listable = TRUE
	name = "Feral Claws"
	desc = "You can draw natural claws, isolated from the old broader feral package."
	category = "Physical"
	point_value = 3
	tags = list("body_weapon")
	legacy_sources = list(/datum/virtue/utility/wild_born)

/datum/aspect/positive/feral_claws/apply_post_equipment(mob/living/carbon/human/H)
	. = ..()
	var/obj/effect/proc_holder/spell/self/feral_claws/claw_ability = new()
	H.mind?.AddSpell(claw_ability)

/datum/aspect/positive/feral_claws/get_extra_summary_lines()
	return list("Ability: Feral claws")

// --- Migrated aspects from legacy virtues (split per-choice where appropriate) ---

/datum/aspect/positive/giant_size
	name = "Giant"
	desc = "I've always been larger and stronger than most; bulk and reach are increased."
	category = "Physical"
	point_value = 5
	added_traits = list(TRAIT_BIGGUY, TRAIT_DEATHBYSNUSNU)
	legacy_sources = list(/datum/virtue/size/giant)

/datum/aspect/positive/devotee_minor
	name = "Devotee"
	desc = "A minor bond with a Patron: basic devotional training and small holy skill."
	category = "Magicks"
	point_value = 5
	added_skills = list(/datum/skill/magic/holy = 1)
	tags = list("faith")
	legacy_sources = list(/datum/virtue/combat/devotee)

/datum/aspect/positive/deadened
	name = "Deadened"
	desc = "A terrible past left you numb. Emotional shocks have less effect."
	category = "Physical"
	point_value = 5
	added_traits = list(TRAIT_NOMOOD)
	legacy_sources = list(/datum/virtue/utility/deadened)

/datum/aspect/positive/failed_squire_tools
	name = "Failed Squire"
	desc = "Training in armour and weapon maintenance: you possess basic repair tools."
	category = "Physical"
	point_value = 10
	added_traits = list(TRAIT_SQUIRE_REPAIR)
	added_stashed_items = list(
		"Hammer" = /obj/item/rogueweapon/hammer/iron,
		"Polishing Cream" = /obj/item/polishing_cream,
		"Fine Brush" = /obj/item/armor_brush
	)
	legacy_sources = list(/datum/virtue/utility/failed_squire)

/datum/aspect/positive/linguist
	name = "Intellectual"
	desc = "Years with books or foreign tongues; reading skill and some notes are available."
	category = "Social"
	point_value = 10
	added_traits = list(TRAIT_INTELLECTUAL)
	added_skills = list(/datum/skill/misc/reading = 3)
	added_stashed_items = list(
		"Quill" = /obj/item/natural/feather,
		"Scroll #1" = /obj/item/paper/scroll,
		"Scroll #2" = /obj/item/paper/scroll,
		"Book Crafting Kit" = /obj/item/book_crafting_kit
	)
	legacy_sources = list(/datum/virtue/utility/linguist)

/datum/aspect/positive/deathless
	name = "Deathless"
	desc = "A weird inward unlivingness: you do not hunger and do not breathe."
	category = "Physical"
	point_value = 10
	added_traits = list(TRAIT_NOHUNGER, TRAIT_NOBREATH)
	legacy_sources = list(/datum/virtue/utility/deathless)

/datum/aspect/positive/performer
	name = "Performer"
	desc = "Musical and showmanship training — instrument skill and social talents."
	category = "Social"
	point_value = 4
	added_traits = list(TRAIT_NUTCRACKER, TRAIT_GOODLOVER)
	added_skills = list(/datum/skill/misc/music = 4)
	legacy_sources = list(/datum/virtue/utility/performer)

/datum/aspect/positive/unseemly
	name = "Unseemly"
	desc = "Your looks make strong first impressions negative, but grant certain odd resistances."
	category = "Social"
	point_value = 0
	added_traits = list(TRAIT_UNSEEMLY, TRAIT_NOSTINK)
	legacy_sources = list(/datum/virtue/utility/ugly)

/datum/aspect/positive/woodwalker
	name = "Woodwalker"
	desc = "Foragers and light-footed in the wilds; gather more and break fewer twigs."
	category = "Physical"
	point_value = 10
	added_traits = list(TRAIT_WOODWALKER, TRAIT_OUTDOORSMAN)
	legacy_sources = list(/datum/virtue/utility/woodwalker)

/datum/aspect/positive/defiled_keyholder
	name = "Defiled Keyholder"
	desc = "Knowledge of heretic conclaves; secretive connections."
	category = "Magicks"
	point_value = 5
	added_traits = list(TRAIT_ZURCH)
	legacy_sources = list(/datum/virtue/heretic/zchurch_keyholder)

/datum/aspect/positive/mountable
	name = "Mountable"
	desc = "Trained to be used as a mount; others may ride you."
	category = "Physical"
	point_value = 2
	added_traits = list(TRAIT_PONYGIRL_RIDEABLE)
	legacy_sources = list(/datum/virtue/utility/mountable)

/datum/aspect/positive/tolerant
	name = "Tolerant"
	desc = "A temperament that prevents certain negative stress events from some species."
	category = "Social"
	point_value = 2
	added_traits = list(TRAIT_TOLERANT)
	legacy_sources = list(/datum/virtue/utility/tolerant)

/datum/aspect/positive/dust_runner
	name = "Dust Runner"
	desc = "A stash and skills useful for running contraband."
	category = "Social"
	point_value = 4
	added_skills = list(/datum/skill/craft/alchemy = 1)
	added_stashed_items = list(
		"Satchel #1" = /obj/item/storage/backpack/rogue/satchel/mule,
		"Satchel #2" = /obj/item/storage/backpack/rogue/satchel/mule,
		"Dagger" = /obj/item/rogueweapon/huntingknife/idagger/virtue
	)
	legacy_sources = list(/datum/virtue/thief/drug_runner)

/datum/aspect/positive/cunning_provisioner
	name = "Cunning Provisioner"
	desc = "A knack for pilfered supplies and basic cooking/fishing know-how."
	category = "Labor"
	point_value = 4
	added_traits = list(TRAIT_HOMESTEAD_EXPERT)
	added_stashed_items = list("Bag of Food" = /obj/item/storage/roguebag/food)
	added_skills = list(/datum/skill/craft/cooking = 3, /datum/skill/labor/fishing = 2)
	legacy_sources = list(/datum/virtue/utility/granary)

/datum/aspect/positive/forester
	name = "Forester"
	desc = "Forest-born skills: tools and gathering skillset to survive outdoors."
	category = "Labor"
	point_value = 4
	added_traits = list(TRAIT_HOMESTEAD_EXPERT)
	added_stashed_items = list("Trusty Hoe" = /obj/item/rogueweapon/hoe)
	added_skills = list(/datum/skill/craft/cooking = 2, /datum/skill/misc/athletics = 2, /datum/skill/labor/farming = 2, /datum/skill/labor/fishing = 2, /datum/skill/labor/lumberjacking = 2)
	legacy_sources = list(/datum/virtue/utility/forester)

/datum/aspect/positive/pilgrim_homesteader
	name = "Pilgrim"
	desc = "A homesteader's start-kit: tools, food and basic survival trade skills."
	category = "Labor"
	point_value = 4
	added_traits = list(TRAIT_HOMESTEAD_EXPERT)
	added_stashed_items = list("Hoe" = /obj/item/rogueweapon/hoe, "Bag of Food" = /obj/item/storage/roguebag/food, "Hunting Knife" = /obj/item/rogueweapon/huntingknife)
	added_skills = list(/datum/skill/craft/cooking = 3, /datum/skill/misc/athletics = 2, /datum/skill/labor/farming = 3)
	legacy_sources = list(/datum/virtue/utility/homesteader)

/datum/aspect/positive/arsonist
	name = "Arsonist"
	desc = "Hidden pyrotechnic tools and the knack for explosive craft."
	category = "Labor"
	point_value = 4
	added_traits = list(TRAIT_ALCHEMY_EXPERT)
	added_skills = list(/datum/skill/craft/alchemy = 1)
	added_stashed_items = list("Firebomb #1" = /obj/item/bomb, "Firebomb #2" = /obj/item/bomb)
	legacy_sources = list(/datum/virtue/items/arsonist)

// Prowler choices split into individual aspects (legacy mapped to the prowler virtue)
/datum/aspect/positive/prosthetic_left_arm_bronze
	name = "Left Arm (Bronze Prosthetic)"
	desc = "A bronze prosthetic left arm; grants engineering aptitude."
	category = "Physical"
	point_value = 1
	added_skills = list(/datum/skill/craft/engineering = 1)
	legacy_sources = list(/datum/virtue/prosthetics/prosthetic_specialist)

/datum/aspect/positive/prosthetic_left_arm_iron
	name = "Left Arm (Iron Prosthetic)"
	desc = "An iron cosmetic prosthetic left arm; grants engineering aptitude."
	category = "Physical"
	point_value = 1
	added_skills = list(/datum/skill/craft/engineering = 1)
	legacy_sources = list(/datum/virtue/prosthetics/prosthetic_specialist)

/datum/aspect/positive/prosthetic_left_arm_steel
	name = "Left Arm (Steel Prosthetic)"
	desc = "A steel cosmetic prosthetic left arm; grants engineering aptitude."
	category = "Physical"
	point_value = 1
	added_skills = list(/datum/skill/craft/engineering = 1)
	legacy_sources = list(/datum/virtue/prosthetics/prosthetic_specialist)

/datum/aspect/positive/prosthetic_left_arm_gold
	name = "Left Arm (Gold Prosthetic)"
	desc = "A gold cosmetic prosthetic left arm; grants engineering aptitude."
	category = "Physical"
	point_value = 1
	added_skills = list(/datum/skill/craft/engineering = 1)
	legacy_sources = list(/datum/virtue/prosthetics/prosthetic_specialist)

/datum/aspect/positive/prosthetic_right_arm_bronze
	name = "Right Arm (Bronze Prosthetic)"
	desc = "A bronze prosthetic right arm; grants engineering aptitude."
	category = "Physical"
	point_value = 1
	added_skills = list(/datum/skill/craft/engineering = 1)
	legacy_sources = list(/datum/virtue/prosthetics/prosthetic_specialist)

/datum/aspect/positive/prosthetic_right_arm_iron
	name = "Right Arm (Iron Prosthetic)"
	desc = "An iron cosmetic prosthetic right arm; grants engineering aptitude."
	category = "Physical"
	point_value = 1
	added_skills = list(/datum/skill/craft/engineering = 1)
	legacy_sources = list(/datum/virtue/prosthetics/prosthetic_specialist)

/datum/aspect/positive/prosthetic_right_arm_steel
	name = "Right Arm (Steel Prosthetic)"
	desc = "A steel cosmetic prosthetic right arm; grants engineering aptitude."
	category = "Physical"
	point_value = 1
	added_skills = list(/datum/skill/craft/engineering = 1)
	legacy_sources = list(/datum/virtue/prosthetics/prosthetic_specialist)

/datum/aspect/positive/prosthetic_right_arm_gold
	name = "Right Arm (Gold Prosthetic)"
	desc = "A gold cosmetic prosthetic right arm; grants engineering aptitude."
	category = "Physical"
	point_value = 1
	added_skills = list(/datum/skill/craft/engineering = 1)
	legacy_sources = list(/datum/virtue/prosthetics/prosthetic_specialist)

/datum/aspect/positive/prosthetic_left_leg_bronze
	name = "Left Leg (Bronze Prosthetic)"
	desc = "A bronze prosthetic left leg; grants engineering aptitude."
	category = "Physical"
	point_value = 1
	added_skills = list(/datum/skill/craft/engineering = 1)
	legacy_sources = list(/datum/virtue/prosthetics/prosthetic_specialist)

/datum/aspect/positive/prosthetic_left_leg_iron
	name = "Left Leg (Iron Prosthetic)"
	desc = "An iron cosmetic prosthetic left leg; grants engineering aptitude."
	category = "Physical"
	point_value = 1
	added_skills = list(/datum/skill/craft/engineering = 1)
	legacy_sources = list(/datum/virtue/prosthetics/prosthetic_specialist)

/datum/aspect/positive/prosthetic_left_leg_steel
	name = "Left Leg (Steel Prosthetic)"
	desc = "A steel cosmetic prosthetic left leg; grants engineering aptitude."
	category = "Physical"
	point_value = 1
	added_skills = list(/datum/skill/craft/engineering = 1)
	legacy_sources = list(/datum/virtue/prosthetics/prosthetic_specialist)

/datum/aspect/positive/prosthetic_left_leg_gold
	name = "Left Leg (Gold Prosthetic)"
	desc = "A gold cosmetic prosthetic left leg; grants engineering aptitude."
	category = "Physical"
	point_value = 1
	added_skills = list(/datum/skill/craft/engineering = 1)
	legacy_sources = list(/datum/virtue/prosthetics/prosthetic_specialist)

/datum/aspect/positive/prosthetic_right_leg_bronze
	name = "Right Leg (Bronze Prosthetic)"
	desc = "A bronze prosthetic right leg; grants engineering aptitude."
	category = "Physical"
	point_value = 1
	added_skills = list(/datum/skill/craft/engineering = 1)
	legacy_sources = list(/datum/virtue/prosthetics/prosthetic_specialist)

/datum/aspect/positive/prosthetic_right_leg_iron
	name = "Right Leg (Iron Prosthetic)"
	desc = "An iron cosmetic prosthetic right leg; grants engineering aptitude."
	category = "Physical"
	point_value = 1
	added_skills = list(/datum/skill/craft/engineering = 1)
	legacy_sources = list(/datum/virtue/prosthetics/prosthetic_specialist)

/datum/aspect/positive/prosthetic_right_leg_steel
	name = "Right Leg (Steel Prosthetic)"
	desc = "A steel cosmetic prosthetic right leg; grants engineering aptitude."
	category = "Physical"
	point_value = 1
	added_skills = list(/datum/skill/craft/engineering = 1)
	legacy_sources = list(/datum/virtue/prosthetics/prosthetic_specialist)

/datum/aspect/positive/prosthetic_right_leg_gold
	name = "Right Leg (Gold Prosthetic)"
	desc = "A gold cosmetic prosthetic right leg; grants engineering aptitude."
	category = "Physical"
	point_value = 1
	added_skills = list(/datum/skill/craft/engineering = 1)
	legacy_sources = list(/datum/virtue/prosthetics/prosthetic_specialist)

// Weapon specialist common bundles (split)
/datum/aspect/positive/weapon_duelist
	name = "Duelist's Set"
	desc = "A duelist's weapon set and matching skillbonus."
	category = "Physical"
	point_value = 3
	added_skills = list(/datum/skill/combat/swords = SKILL_LEVEL_JOURNEYMAN, /datum/skill/combat/knives = SKILL_LEVEL_JOURNEYMAN)
	added_stashed_items = list("Messer" = /obj/item/rogueweapon/sword/short/messer/iron/virtue, "Parrying Dagger" = /obj/item/rogueweapon/huntingknife/idagger/virtue)
	legacy_sources = list(/datum/virtue/combat/weapon_specialist)

/datum/aspect/positive/weapon_dungeoneer
	name = "Dungeoneer's Set"
	desc = "Mining and subterranean tools; axes and a whip for close work."
	category = "Physical"
	point_value = 3
	added_skills = list(/datum/skill/combat/axes = SKILL_LEVEL_JOURNEYMAN, /datum/skill/combat/whipsflails = SKILL_LEVEL_JOURNEYMAN)
	added_stashed_items = list("Stone Axe" = /obj/item/rogueweapon/stoneaxe/woodcut, "Whip" = /obj/item/rogueweapon/whip)
	legacy_sources = list(/datum/virtue/combat/weapon_specialist)

/datum/aspect/positive/weapon_militiaman
	name = "Militiaman's Set"
	desc = "Polearm and mace training plus starter arms."
	category = "Physical"
	point_value = 3
	added_skills = list(/datum/skill/combat/polearms = SKILL_LEVEL_JOURNEYMAN, /datum/skill/combat/maces = SKILL_LEVEL_JOURNEYMAN)
	added_stashed_items = list("Spear" = /obj/item/rogueweapon/spear, "Mace" = /obj/item/rogueweapon/mace)
	legacy_sources = list(/datum/virtue/combat/weapon_specialist)

/datum/aspect/positive/weapon_shepherd
	name = "Shepherd's Tools"
	desc = "A staff and simple ranged tools for a pastoral fighter."
	category = "Physical"
	point_value = 3
	added_skills = list(/datum/skill/combat/staves = SKILL_LEVEL_JOURNEYMAN, /datum/skill/combat/slings = SKILL_LEVEL_JOURNEYMAN)
	added_stashed_items = list("Quarterstaff" = /obj/item/rogueweapon/woodstaff/quarterstaff/iron, "Sling" = /obj/item/quiver/sling/iron)
	legacy_sources = list(/datum/virtue/combat/weapon_specialist)

/datum/aspect/positive/weapon_archer
	name = "Archer's Set"
	desc = "Bow set and archery skill."
	category = "Physical"
	point_value = 3
	added_skills = list(/datum/skill/combat/bows = SKILL_LEVEL_JOURNEYMAN)
	added_stashed_items = list("Recurve Bow" = /obj/item/gun/ballistic/revolver/grenadelauncher/bow/recurve, "Quiver" = /obj/item/quiver/arrows)
	legacy_sources = list(/datum/virtue/combat/weapon_specialist)

/datum/aspect/positive/weapon_pugilist_knuckles
	name = "Pugilist (Knuckles)"
	desc = "Bronze knuckles and unarmed fighting training."
	category = "Physical"
	point_value = 3
	added_skills = list(/datum/skill/combat/unarmed = SKILL_LEVEL_JOURNEYMAN, /datum/skill/combat/wrestling = SKILL_LEVEL_JOURNEYMAN)
	added_stashed_items = list("Bronze Knuckles #1" = /obj/item/rogueweapon/knuckles/bronzeknuckles, "Bronze Knuckles #2" = /obj/item/rogueweapon/knuckles/bronzeknuckles)
	legacy_sources = list(/datum/virtue/combat/weapon_specialist)

/datum/aspect/positive/weapon_pugilist_katar
	name = "Pugilist (Katar)"
	desc = "Bronze katar pair and hand-to-hand training."
	category = "Physical"
	point_value = 3
	added_skills = list(/datum/skill/combat/unarmed = SKILL_LEVEL_JOURNEYMAN, /datum/skill/combat/wrestling = SKILL_LEVEL_JOURNEYMAN)
	added_stashed_items = list("Bronze Katar #1" = /obj/item/rogueweapon/katar/bronze, "Bronze Katar #2" = /obj/item/rogueweapon/katar/bronze)
	legacy_sources = list(/datum/virtue/combat/weapon_specialist)

// Individual weapon choices
/datum/aspect/positive/weapon_iron_arming_sword
	name = "Iron Arming Sword"
	desc = "A solid iron arming sword and corresponding sword skill."
	category = "Physical"
	point_value = 2
	added_skills = list(/datum/skill/combat/swords = SKILL_LEVEL_JOURNEYMAN)
	added_stashed_items = list("Iron Arming Sword" = /obj/item/rogueweapon/sword/iron)
	legacy_sources = list(/datum/virtue/combat/weapon_specialist)

/datum/aspect/positive/weapon_bronze_arming_sword
	name = "Bronze Arming Sword"
	desc = "A bronze arming sword and sword skill."
	category = "Physical"
	point_value = 2
	added_skills = list(/datum/skill/combat/swords = SKILL_LEVEL_JOURNEYMAN)
	added_stashed_items = list("Bronze Arming Sword" = /obj/item/rogueweapon/sword/bronze)
	legacy_sources = list(/datum/virtue/combat/weapon_specialist)

/datum/aspect/positive/weapon_iron_messer
	name = "Iron Messer"
	desc = "A short messer and basic sword skill."
	category = "Physical"
	point_value = 1
	added_skills = list(/datum/skill/combat/swords = SKILL_LEVEL_JOURNEYMAN)
	added_stashed_items = list("Messer" = /obj/item/rogueweapon/sword/short/messer/iron/virtue)
	legacy_sources = list(/datum/virtue/combat/weapon_specialist)

/datum/aspect/positive/weapon_iron_short_sword
	name = "Iron Short Sword"
	desc = "A short iron sword and basic sword training."
	category = "Physical"
	point_value = 1
	added_skills = list(/datum/skill/combat/swords = SKILL_LEVEL_JOURNEYMAN)
	added_stashed_items = list("Short Sword" = /obj/item/rogueweapon/sword/short/iron)
	legacy_sources = list(/datum/virtue/combat/weapon_specialist)

/datum/aspect/positive/weapon_iron_saber
	name = "Iron Saber"
	desc = "A saber and skilled sword training."
	category = "Physical"
	point_value = 2
	added_skills = list(/datum/skill/combat/swords = SKILL_LEVEL_JOURNEYMAN)
	added_stashed_items = list("Iron Saber" = /obj/item/rogueweapon/sword/sabre/iron)
	legacy_sources = list(/datum/virtue/combat/weapon_specialist)

/datum/aspect/positive/weapon_bronze_hunting_knife
	name = "Bronze Hunting Knife"
	desc = "A hunting knife and knife training."
	category = "Physical"
	point_value = 1
	added_skills = list(/datum/skill/combat/knives = SKILL_LEVEL_JOURNEYMAN)
	added_stashed_items = list("Hunting Knife" = /obj/item/rogueweapon/huntingknife/bronze)
	legacy_sources = list(/datum/virtue/combat/weapon_specialist)

/datum/aspect/positive/weapon_parrying_dagger
	name = "Parrying Dagger"
	desc = "A parrying dagger and knife training."
	category = "Physical"
	point_value = 1
	added_skills = list(/datum/skill/combat/knives = SKILL_LEVEL_JOURNEYMAN)
	added_stashed_items = list("Parrying Dagger" = /obj/item/rogueweapon/huntingknife/idagger/virtue)
	legacy_sources = list(/datum/virtue/combat/weapon_specialist)

/datum/aspect/positive/weapon_bronze_axe
	name = "Bronze Axe"
	desc = "A bronze axe and axe training."
	category = "Physical"
	point_value = 2
	added_skills = list(/datum/skill/combat/axes = SKILL_LEVEL_JOURNEYMAN)
	added_stashed_items = list("Bronze Axe" = /obj/item/rogueweapon/stoneaxe/woodcut/bronze)
	legacy_sources = list(/datum/virtue/combat/weapon_specialist)

/datum/aspect/positive/weapon_iron_axe
	name = "Iron Axe"
	desc = "A sturdy iron axe and axe training."
	category = "Physical"
	point_value = 2
	added_skills = list(/datum/skill/combat/axes = SKILL_LEVEL_JOURNEYMAN)
	added_stashed_items = list("Iron Axe" = /obj/item/rogueweapon/stoneaxe/woodcut)
	legacy_sources = list(/datum/virtue/combat/weapon_specialist)

/datum/aspect/positive/weapon_iron_greataxe
	name = "Iron Greataxe"
	desc = "A heavy greataxe and advanced axe training."
	category = "Physical"
	point_value = 3
	added_skills = list(/datum/skill/combat/axes = SKILL_LEVEL_JOURNEYMAN)
	added_stashed_items = list("Greataxe" = /obj/item/rogueweapon/greataxe)
	legacy_sources = list(/datum/virtue/combat/weapon_specialist)

/datum/aspect/positive/weapon_bronze_mace
	name = "Bronze Mace"
	desc = "A bronze mace and mace training."
	category = "Physical"
	point_value = 2
	added_skills = list(/datum/skill/combat/maces = SKILL_LEVEL_JOURNEYMAN)
	added_stashed_items = list("Bronze Mace" = /obj/item/rogueweapon/mace/bronze)
	legacy_sources = list(/datum/virtue/combat/weapon_specialist)

/datum/aspect/positive/weapon_iron_mace
	name = "Iron Mace"
	desc = "An iron mace and mace training."
	category = "Physical"
	point_value = 2
	added_skills = list(/datum/skill/combat/maces = SKILL_LEVEL_JOURNEYMAN)
	added_stashed_items = list("Iron Mace" = /obj/item/rogueweapon/mace)
	legacy_sources = list(/datum/virtue/combat/weapon_specialist)

/datum/aspect/positive/weapon_iron_flail
	name = "Iron Flail"
	desc = "A flail and related mace training."
	category = "Physical"
	point_value = 2
	added_skills = list(/datum/skill/combat/maces = SKILL_LEVEL_JOURNEYMAN)
	added_stashed_items = list("Flail" = /obj/item/rogueweapon/flail)
	legacy_sources = list(/datum/virtue/combat/weapon_specialist)

/datum/aspect/positive/weapon_iron_warhammer
	name = "Iron Warhammer"
	desc = "A warhammer and heavy mace training."
	category = "Physical"
	point_value = 2
	added_skills = list(/datum/skill/combat/maces = SKILL_LEVEL_JOURNEYMAN)
	added_stashed_items = list("Warhammer" = /obj/item/rogueweapon/mace/warhammer)
	legacy_sources = list(/datum/virtue/combat/weapon_specialist)

/datum/aspect/positive/weapon_bronze_spear
	name = "Bronze Spear"
	desc = "A bronze spear and polearm training."
	category = "Physical"
	point_value = 2
	added_skills = list(/datum/skill/combat/polearms = SKILL_LEVEL_JOURNEYMAN)
	added_stashed_items = list("Bronze Spear" = /obj/item/rogueweapon/spear/bronze)
	legacy_sources = list(/datum/virtue/combat/weapon_specialist)

/datum/aspect/positive/weapon_wooden_spear
	name = "Wooden Spear"
	desc = "A simple wooden spear and polearm training."
	category = "Physical"
	point_value = 1
	added_skills = list(/datum/skill/combat/polearms = SKILL_LEVEL_JOURNEYMAN)
	added_stashed_items = list("Wooden Spear" = /obj/item/rogueweapon/spear)
	legacy_sources = list(/datum/virtue/combat/weapon_specialist)

/datum/aspect/positive/weapon_leather_whip
	name = "Leather Whip"
	desc = "A leather whip and whip/flail training."
	category = "Physical"
	point_value = 1
	added_skills = list(/datum/skill/combat/whipsflails = SKILL_LEVEL_JOURNEYMAN)
	added_stashed_items = list("Leather Whip" = /obj/item/rogueweapon/whip)
	legacy_sources = list(/datum/virtue/combat/weapon_specialist)


/datum/aspect/positive/beautiful_presence
	listable = TRUE
	name = "Beautiful Presence"
	desc = "You are striking, alluring, and carry yourself like it."
	category = "Social"
	point_value = 2
	added_traits = list(TRAIT_BEAUTIFUL, TRAIT_GOODLOVER)
	added_stashed_items = list("Hand Mirror" = /obj/item/handmirror)
	legacy_sources = list(/datum/virtue/utility/well_off)

/datum/aspect/positive/resident_of_the_vale
	listable = TRUE
	name = "Resident of the Vale"
	desc = "You belong here and are treated as such by the treasury."
	category = "Social"
	point_value = 2
	added_traits = list(TRAIT_RESIDENT)
	legacy_sources = list(/datum/virtue/utility/well_off)

/datum/aspect/positive/wealthy_appraiser
	listable = TRUE
	name = "Wealthy Appraiser"
	desc = "You can judge worth, read prices, and start with a proper purse."
	category = "Social"
	point_value = 3
	added_traits = list(TRAIT_SEEPRICES)
	added_skills = list(/datum/skill/misc/reading = 1)
	added_stashed_items = list("Weighty Coinpurse" = /obj/item/storage/belt/rogue/pouch/coins/virtuepouch)
	legacy_sources = list(/datum/virtue/utility/well_off)

/datum/aspect/positive/wealthy_appraiser/apply_post_equipment(mob/living/carbon/human/H)
	. = ..()
	if(!H.mind?.has_spell(/obj/effect/proc_holder/spell/invoked/appraise/secular))
		H.mind?.AddSpell(new /obj/effect/proc_holder/spell/invoked/appraise/secular)

/datum/aspect/positive/wealthy_appraiser/get_extra_summary_lines()
	return list("Ability: Appraise")

/datum/aspect/positive/empathic
	listable = TRUE
	name = "Empathic"
	desc = "Reading people comes naturally to you."
	category = "Social"
	point_value = 2
	added_traits = list(TRAIT_EMPATH)
	legacy_sources = list(/datum/virtue/utility/well_off)

/datum/aspect/positive/light_steps
	listable = TRUE
	name = "Light Steps"
	desc = "You move quietly and crouch with more ease."
	category = "Physical"
	point_value = 2
	added_traits = list(TRAIT_LIGHT_STEP)
	added_skills = list(/datum/skill/misc/sneaking = 3)
	legacy_sources = list(/datum/virtue/utility/prowler)

/datum/aspect/positive/night_vision
	listable = TRUE
	name = "Night Vision"
	desc = "Darkness gives up more of its detail to you."
	category = "Physical"
	point_value = 2
	added_traits = list(TRAIT_DARKVISION)
	legacy_sources = list(/datum/virtue/utility/prowler)

/datum/aspect/positive/second_voice
	listable = TRUE
	name = "Second Voice"
	desc = "You can alter and swap your speaking voice."
	category = "Social"
	point_value = 2
	legacy_sources = list(/datum/virtue/utility/prowler)

/datum/aspect/positive/second_voice/apply_post_equipment(mob/living/carbon/human/H)
	. = ..()
	H.verbs |= /mob/living/carbon/human/proc/changevoice
	H.verbs |= /mob/living/carbon/human/proc/swapvoice

/datum/aspect/positive/second_voice/get_extra_summary_lines()
	return list("Ability: Change and swap voice")

/datum/aspect/positive/lockpicking_arts
	listable = TRUE
	name = "Lockpicking Arts"
	desc = "You know locks well and keep the tools for them nearby."
	category = "Physical"
	point_value = 2
	added_skills = list(/datum/skill/misc/lockpicking = 3)
	added_stashed_items = list("Lockpick Ring" = /obj/item/lockpickring/mundane)
	legacy_sources = list(/datum/virtue/utility/prowler)

/datum/aspect/positive/acrobatic
	listable = TRUE
	name = "Acrobatic"
	desc = "Your jumps are cleaner and more precise on flat ground."
	category = "Physical"
	point_value = 2
	added_traits = list(TRAIT_LEAPER)
	legacy_sources = list(/datum/virtue/utility/prowler)

/datum/aspect/positive/sleuth
	listable = TRUE
	name = "Sleuth"
	desc = "You track better than most people realize."
	category = "Physical"
	point_value = 2
	added_traits = list(TRAIT_SLEUTH)
	added_skills = list(/datum/skill/misc/tracking = 3)
	legacy_sources = list(/datum/virtue/utility/prowler)

/datum/aspect/positive/keen_ears
	listable = TRUE
	name = "Keen Ears"
	desc = "You catch more speech and subtle noise than most."
	category = "Physical"
	point_value = 2
	added_traits = list(TRAIT_KEENEARS)
	legacy_sources = list(/datum/virtue/utility/prowler)

/datum/aspect/positive/waterborn
	listable = TRUE
	name = "Waterborn"
	desc = "You breathe underwater and move through it more comfortably."
	category = "Physical"
	point_value = 3
	added_traits = list(TRAIT_WATERBREATHING, TRAIT_ABYSSOR_SWIM)
	legacy_sources = list(/datum/virtue/utility/wild_born)

/datum/aspect/positive/feral_bite
	listable = TRUE
	name = "Feral Bite"
	desc = "Your mouth is a more credible weapon than it should be."
	category = "Physical"
	point_value = 2
	added_traits = list(TRAIT_FERAL_BITE)

/datum/aspect/positive/feral_appetite
	listable = TRUE
	name = "Feral Appetite"
	desc = "Rotten, raw, and ugly meals bother you far less."
	category = "Physical"
	point_value = 2
	added_traits = list(TRAIT_NASTY_EATER)
	legacy_sources = list(/datum/virtue/utility/wild_born)

/datum/aspect/positive/blacksmithing_apprentice
	listable = TRUE
	name = "Blacksmithing Apprentice"
	desc = "You trained across the metal trades."
	category = "Labor"
	point_value = 3
	added_traits = list(TRAIT_SMITHING_EXPERT)
	added_skills = list(
		/datum/skill/craft/crafting = 2,
		/datum/skill/craft/weaponsmithing = 2,
		/datum/skill/craft/armorsmithing = 2,
		/datum/skill/craft/blacksmithing = 2,
		/datum/skill/craft/smelting = 2
	)
	legacy_sources = list(/datum/virtue/utility/skilled_apprentice)

/datum/aspect/positive/tailoring_apprentice
	listable = TRUE
	name = "Tailoring Apprentice"
	desc = "You know cloth, leather, and the tools that shape them."
	category = "Labor"
	point_value = 3
	added_traits = list(TRAIT_SEWING_EXPERT)
	added_skills = list(
		/datum/skill/craft/crafting = 2,
		/datum/skill/labor/butchering = 2,
		/datum/skill/craft/sewing = 2,
		/datum/skill/craft/tanning = 2
	)
	added_stashed_items = list("Needle" = /obj/item/needle, "Scissors" = /obj/item/rogueweapon/huntingknife/scissors)
	legacy_sources = list(/datum/virtue/utility/skilled_apprentice)

/datum/aspect/positive/medicine_apprentice
	listable = TRUE
	name = "Medicine Apprentice"
	desc = "You trained in diagnosis, practical medicine, and rough alchemy."
	category = "Labor"
	point_value = 3
	added_traits = list(TRAIT_MEDICINE_EXPERT, TRAIT_ALCHEMY_EXPERT)
	added_skills = list(
		/datum/skill/craft/crafting = 2,
		/datum/skill/craft/alchemy = 2,
		/datum/skill/misc/medicine = 2
	)
	added_stashed_items = list("Medicine Pouch" = /obj/item/storage/belt/rogue/pouch/medicine)
	legacy_sources = list(/datum/virtue/utility/skilled_apprentice)

/datum/aspect/positive/medicine_apprentice/apply_post_equipment(mob/living/carbon/human/H)
	. = ..()
	if(!H.mind?.has_spell(/obj/effect/proc_holder/spell/invoked/diagnose/secular))
		H.mind?.AddSpell(new /obj/effect/proc_holder/spell/invoked/diagnose/secular)

/datum/aspect/positive/medicine_apprentice/get_extra_summary_lines()
	return list("Ability: Diagnose")

/datum/aspect/positive/hunting_apprentice
	listable = TRUE
	name = "Hunting Apprentice"
	desc = "You learned the work of surviving off the land."
	category = "Labor"
	point_value = 3
	added_traits = list(TRAIT_SURVIVAL_EXPERT)
	added_skills = list(
		/datum/skill/craft/crafting = 2,
		/datum/skill/labor/butchering = 2,
		/datum/skill/craft/sewing = 2,
		/datum/skill/craft/tanning = 2,
		/datum/skill/misc/tracking = 2
	)
	legacy_sources = list(/datum/virtue/utility/skilled_apprentice)

/datum/aspect/positive/engineering_apprentice
	listable = TRUE
	name = "Engineering Apprentice"
	desc = "You know how structures, materials, and practical mechanisms come together."
	category = "Labor"
	point_value = 3
	added_traits = list(TRAIT_SMITHING_EXPERT)
	added_skills = list(
		/datum/skill/craft/crafting = 2,
		/datum/skill/craft/carpentry = 2,
		/datum/skill/craft/masonry = 2,
		/datum/skill/craft/engineering = 2,
		/datum/skill/craft/smelting = 2,
		/datum/skill/craft/ceramics = 2
	)
	added_stashed_items = list(
		"Hammer" = /obj/item/rogueweapon/hammer/wood,
		"Chisel" = /obj/item/rogueweapon/chisel,
		"Hand Saw" = /obj/item/rogueweapon/handsaw
	)
	legacy_sources = list(/datum/virtue/utility/skilled_apprentice)

/datum/aspect/positive/mining_apprentice
	listable = TRUE
	name = "Mining Apprentice"
	desc = "You know ore, stone, and the tools to chase both."
	category = "Labor"
	point_value = 2
	added_traits = list(TRAIT_SMITHING_EXPERT)
	added_skills = list(/datum/skill/labor/mining = 3)
	added_stashed_items = list("Steel Pickaxe" = /obj/item/rogueweapon/pick/steel, "Lamptern" = /obj/item/flashlight/flare/torch/lantern)
	legacy_sources = list(/datum/virtue/utility/laborious_apprentice)

/datum/aspect/positive/lumberjacking_apprentice
	listable = TRUE
	name = "Lumberjacking Apprentice"
	desc = "You learned how to bring woodlands down into useful shapes."
	category = "Labor"
	point_value = 2
	added_skills = list(/datum/skill/labor/lumberjacking = 3)
	added_stashed_items = list("Iron Axe" = /obj/item/rogueweapon/stoneaxe/woodcut)
	legacy_sources = list(/datum/virtue/utility/laborious_apprentice)

// Remaining direct virtue wrappers for coverage

/datum/aspect/positive/legacy_virtue/guarded
	category = "Physical"
	virtue_type = /datum/virtue/combat/guarded

/datum/aspect/positive/legacy_virtue/rotcured
	category = "Physical"
	virtue_type = /datum/virtue/combat/rotcured

/datum/aspect/positive/legacy_virtue/dualwielder
	category = "Physical"
	virtue_type = /datum/virtue/combat/dualwielder

/datum/aspect/positive/legacy_virtue/sentinel_of_wits
	category = "Physical"
	virtue_type = /datum/virtue/combat/sharp

/datum/aspect/positive/legacy_virtue/combat_aware
	category = "Physical"
	virtue_type = /datum/virtue/combat/combat_aware

/datum/aspect/positive/legacy_virtue/natural_armor
	category = "Physical"
	virtue_type = /datum/virtue/combat/tough_hide

