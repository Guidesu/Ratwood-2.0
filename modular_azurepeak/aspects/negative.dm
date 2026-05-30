/datum/aspect/negative/flaw
	category = "Physical"

/datum/aspect/negative/flaw/New()
	. = ..()
	if(flaw_type)
		var/datum/charflaw/flaw_ref = GLOB.charflaw_singletons?[flaw_type]
		if(!name || name == initial(name))
			name = flaw_ref?.name || name
		if(!desc)
			desc = flaw_ref?.desc || desc
		if(!point_value)
			point_value = aspect_flaw_default_points(flaw_type)
		category = aspect_flaw_default_category(flaw_type)

/proc/aspect_faction_name(faction_flag)
	for(var/faction_name in GLOB.averse_factions)
		if(GLOB.averse_factions[faction_name] == faction_flag)
			return faction_name
	return "Unchosen"

/proc/aspect_valid_faction_flag(faction_flag)
	for(var/faction_name in GLOB.averse_factions)
		if(GLOB.averse_factions[faction_name] == faction_flag)
			return TRUE
	return FALSE

/datum/aspect/negative/flaw/badsight
	listable = TRUE
	name = "Bad Sight"
	desc = "Your vision is poor enough to matter."
	point_value = 2
	tags = list("eyes")
	conflicts = list("eyes")
	flaw_type = /datum/charflaw/badsight
	legacy_sources = list(/datum/charflaw/badsight)

/datum/aspect/negative/flaw/mute
	listable = TRUE
	name = "Mute"
	desc = "You cannot speak normally."
	point_value = 2
	tags = list("voice")
	flaw_type = /datum/charflaw/mute
	legacy_sources = list(/datum/charflaw/mute)

/datum/aspect/negative/flaw/sleepless
	listable = TRUE
	name = "Sleepless"
	desc = "Rest comes poorly to you."
	point_value = 1
	tags = list("sleep")
	flaw_type = /datum/charflaw/sleepless
	legacy_sources = list(/datum/charflaw/sleepless)

/datum/aspect/negative/flaw/narcoleptic
	listable = TRUE
	name = "Narcoleptic"
	desc = "Sleep can take you at dangerous moments."
	point_value = 2
	tags = list("sleep")
	conflicts = list("sleep")
	flaw_type = /datum/charflaw/narcoleptic
	legacy_sources = list(/datum/charflaw/narcoleptic)

/datum/aspect/negative/flaw/weak_heart
	listable = TRUE
	name = "Weak Heart"
	desc = "Stress threatens your heart sooner than it should."
	point_value = 3
	tags = list("heart")
	flaw_type = /datum/charflaw/weak_heart
	legacy_sources = list(/datum/charflaw/weak_heart)

/datum/aspect/negative/flaw/chronic_arthritis
	listable = TRUE
	name = "Chronic Arthritis"
	desc = "Your joints fail you under pressure."
	point_value = 3
	tags = list("chronic_pain")
	conflicts = list("chronic_pain")
	flaw_type = /datum/charflaw/chronic_arthritis
	legacy_sources = list(/datum/charflaw/chronic_arthritis)

/datum/aspect/negative/flaw/chronic_back_pain
	listable = TRUE
	name = "Chronic Back Pain"
	desc = "Your back is a permanent liability."
	point_value = 3
	tags = list("chronic_pain")
	conflicts = list("chronic_pain")
	flaw_type = /datum/charflaw/chronic_back_pain
	legacy_sources = list(/datum/charflaw/chronic_back_pain)

/datum/aspect/negative/flaw/hard_of_hearing
	listable = TRUE
	name = "Hard of Hearing"
	desc = "Your hearing is unreliable."
	point_value = 2
	tags = list("hearing")
	flaw_type = /datum/charflaw/hard_of_hearing
	legacy_sources = list(/datum/charflaw/hard_of_hearing)

/datum/aspect/negative/flaw/old_war_wound
	listable = TRUE
	name = "Old War Wound"
	desc = "An old injury returns when you can least afford it."
	point_value = 2
	tags = list("wound")
	flaw_type = /datum/charflaw/old_war_wound
	legacy_sources = list(/datum/charflaw/old_war_wound)

/datum/aspect/negative/flaw/tremors
	listable = TRUE
	name = "Tremors"
	desc = "Your hands betray you."
	point_value = 2
	tags = list("hands")
	flaw_type = /datum/charflaw/tremors
	legacy_sources = list(/datum/charflaw/tremors)

/datum/aspect/negative/flaw/hemophage
	listable = TRUE
	name = "Hemophage"
	desc = "Blood sustains you; ordinary food does not."
	point_value = 2
	tags = list("diet")
	flaw_type = /datum/charflaw/hemophage
	legacy_sources = list(/datum/charflaw/hemophage)

/datum/aspect/negative/flaw/missing_nose
	listable = TRUE
	name = "Missing Nose"
	desc = "You recover stamina more poorly."
	point_value = 1
	tags = list("face")
	flaw_type = /datum/charflaw/missing_nose
	legacy_sources = list(/datum/charflaw/missing_nose)

/datum/aspect/negative/flaw/ugly
	listable = TRUE
	name = "Ugly"
	desc = "Your appearance works against first impressions."
	point_value = 1
	tags = list("appearance")
	flaw_type = /datum/charflaw/ugly
	legacy_sources = list(/datum/charflaw/ugly)

/datum/aspect/negative/flaw/pacifism
	listable = TRUE
	name = "Pacifism"
	desc = "Violence weighs on you in ways that change play."
	point_value = 1
	tags = list("combat_restriction")
	flaw_type = /datum/charflaw/pacifism
	legacy_sources = list(/datum/charflaw/pacifism)

/datum/aspect/negative/flaw/wood_arm_left
	listable = TRUE
	name = "Wood Arm, Left"
	desc = "Your left arm has been replaced with a wooden prosthetic."
	point_value = 2
	tags = list("left_arm")
	flaw_type = /datum/charflaw/limbloss/arm_l
	legacy_sources = list(/datum/charflaw/limbloss/arm_l)

/datum/aspect/negative/flaw/wood_arm_right
	listable = TRUE
	name = "Wood Arm, Right"
	desc = "Your right arm has been replaced with a wooden prosthetic."
	point_value = 2
	tags = list("right_arm")
	flaw_type = /datum/charflaw/limbloss/arm_r
	legacy_sources = list(/datum/charflaw/limbloss/arm_r)

/datum/aspect/negative/flaw/nudist
	listable = TRUE
	name = "Nudist"
	desc = "Clothing causes you stress, and you will fight to be rid of it."
	point_value = 1
	tags = list("clothing_restriction")
	flaw_type = /datum/charflaw/nudist
	legacy_sources = list(/datum/charflaw/nudist)

/datum/aspect/negative/flaw/nude_sleeper
	listable = TRUE
	name = "Nude Sleeper"
	desc = "You cannot sleep properly while wearing equipment."
	point_value = 1
	tags = list("sleep_restriction")
	flaw_type = /datum/charflaw/nude_sleeper
	legacy_sources = list(/datum/charflaw/nude_sleeper)

/datum/aspect/negative/flaw/devout_follower
	listable = TRUE
	name = "Devout Follower"
	desc = "You must pray regularly or suffer stress and spiritual malaise."
	point_value = 1
	tags = list("faith_obligation")
	flaw_type = /datum/charflaw/addiction/godfearing
	legacy_sources = list(/datum/charflaw/addiction/godfearing)

/datum/aspect/negative/flaw/isolationist
	listable = TRUE
	name = "Isolationist"
	desc = "Crowds stress you, and busy social spaces wear you down."
	point_value = 1
	tags = list("social_stress")
	flaw_type = /datum/charflaw/isolationist
	legacy_sources = list(/datum/charflaw/isolationist)

/datum/aspect/negative/flaw/finicky
	listable = TRUE
	name = "Finicky"
	desc = "You are difficult to satisfy socially and become stressed at both extremes."
	point_value = 1
	tags = list("social_stress")
	flaw_type = /datum/charflaw/finicky
	legacy_sources = list(/datum/charflaw/finicky)

/datum/aspect/negative/flaw/greedy
	listable = TRUE
	name = "Greedy"
	desc = "You need to carry more mammons over time or suffer stress and withdrawal."
	point_value = 2
	tags = list("mammon_dependency")
	flaw_type = /datum/charflaw/greedy
	legacy_sources = list(/datum/charflaw/greedy)

// Additional legacy vice coverage

/datum/aspect/negative/flaw/alcoholic
	listable = TRUE
	flaw_type = /datum/charflaw/addiction/alcoholic
	legacy_sources = list(/datum/charflaw/addiction/alcoholic)

/datum/aspect/negative/flaw/annoying_face
	listable = TRUE
	flaw_type = /datum/charflaw/annoying_face
	legacy_sources = list(/datum/charflaw/annoying_face)

/datum/aspect/negative/flaw/asundered_mind
	listable = TRUE
	flaw_type = /datum/charflaw/mind_broken
	legacy_sources = list(/datum/charflaw/mind_broken)

/datum/aspect/negative/flaw/averse
	listable = TRUE
	flaw_type = /datum/charflaw/averse
	legacy_sources = list(/datum/charflaw/averse)

/datum/aspect/negative/flaw/averse/is_configurable()
	return TRUE

/datum/aspect/negative/flaw/averse/get_default_config()
	var/default_name = null
	for(var/faction_name in GLOB.averse_factions)
		default_name = faction_name
		break
	return list("faction" = GLOB.averse_factions[default_name])

/datum/aspect/negative/flaw/averse/describe_config(list/config)
	if(!islist(config))
		return "Not configured"
	return "Loathes: [aspect_faction_name(config["faction"])]"

/datum/aspect/negative/flaw/averse/validate_config(list/config, list/errors)
	if(!islist(config) || !aspect_valid_faction_flag(config["faction"]))
		LAZYADD(errors, "[name] requires a chosen faction.")
		return FALSE
	return TRUE

/datum/aspect/negative/flaw/averse/configure_for_profile(datum/aspect_profile/profile, datum/preferences/prefs, mob/user)
	var/list/config = profile.ensure_config(type)
	if(!islist(config))
		return FALSE
	var/current_name = aspect_faction_name(config["faction"])
	var/faction_choice = tgui_input_list(user, "Which faction do you loathe?", name, GLOB.averse_factions, current_name)
	if(!faction_choice)
		return FALSE
	config["faction"] = GLOB.averse_factions[faction_choice]
	if(prefs)
		prefs.averse_chosen_faction = config["faction"]
	return TRUE

/datum/aspect/negative/flaw/averse/apply_to_human(mob/living/carbon/human/H, datum/aspect_profile/profile)
	. = ..()
	var/list/config = profile?.get_config(type)
	if(islist(config) && H?.client?.prefs)
		H.client.prefs.averse_chosen_faction = config["faction"]

/datum/aspect/negative/flaw/big_ears
	listable = TRUE
	flaw_type = /datum/charflaw/big_ears
	legacy_sources = list(/datum/charflaw/big_ears)

/datum/aspect/negative/flaw/blindness
	listable = TRUE
	flaw_type = /datum/charflaw/noeyeall
	conflicts = list("eyes")
	tags = list("eyes")
	legacy_sources = list(/datum/charflaw/noeyeall)

/datum/aspect/negative/flaw/caffiend
	listable = TRUE
	flaw_type = /datum/charflaw/addiction/caffiend
	legacy_sources = list(/datum/charflaw/addiction/caffiend)

/datum/aspect/negative/flaw/clamorous
	listable = TRUE
	flaw_type = /datum/charflaw/addiction/clamorous
	legacy_sources = list(/datum/charflaw/addiction/clamorous)

/datum/aspect/negative/flaw/clingy
	listable = TRUE
	flaw_type = /datum/charflaw/clingy
	legacy_sources = list(/datum/charflaw/clingy)

/datum/aspect/negative/flaw/colorblind
	listable = TRUE
	flaw_type = /datum/charflaw/colorblind
	conflicts = list("eyes")
	tags = list("eyes")
	legacy_sources = list(/datum/charflaw/colorblind)

/datum/aspect/negative/flaw/critical_weakness
	listable = TRUE
	flaw_type = /datum/charflaw/critweakness
	legacy_sources = list(/datum/charflaw/critweakness)

/datum/aspect/negative/flaw/cyclops_left
	listable = TRUE
	flaw_type = /datum/charflaw/noeyel
	conflicts = list("eyes")
	tags = list("eyes")
	legacy_sources = list(/datum/charflaw/noeyel)

/datum/aspect/negative/flaw/cyclops_right
	listable = TRUE
	flaw_type = /datum/charflaw/noeyer
	conflicts = list("eyes")
	tags = list("eyes")
	legacy_sources = list(/datum/charflaw/noeyer)

/datum/aspect/negative/flaw/disgraced_noble
	listable = TRUE
	flaw_type = /datum/charflaw/disgraced_noble
	legacy_sources = list(/datum/charflaw/disgraced_noble)

/datum/aspect/negative/flaw/herbivore
	listable = TRUE
	flaw_type = /datum/charflaw/herbivore
	conflicts = list("diet")
	tags = list("diet")
	legacy_sources = list(/datum/charflaw/herbivore)

/datum/aspect/negative/flaw/hunted
	listable = TRUE
	flaw_type = /datum/charflaw/hunted
	legacy_sources = list(/datum/charflaw/hunted)

/datum/aspect/negative/flaw/illiterate
	listable = TRUE
	flaw_type = /datum/charflaw/illiterate
	legacy_sources = list(/datum/charflaw/illiterate)

/datum/aspect/negative/flaw/indebted
	listable = TRUE
	flaw_type = /datum/charflaw/indebted
	legacy_sources = list(/datum/charflaw/indebted)

/datum/aspect/negative/flaw/junkie
	listable = TRUE
	flaw_type = /datum/charflaw/addiction/junkie
	legacy_sources = list(/datum/charflaw/addiction/junkie)

/datum/aspect/negative/flaw/kleptomaniac
	listable = TRUE
	flaw_type = /datum/charflaw/addiction/kleptomaniac
	legacy_sources = list(/datum/charflaw/addiction/kleptomaniac)

/datum/aspect/negative/flaw/leprosy
	listable = TRUE
	flaw_type = /datum/charflaw/leprosy
	legacy_sources = list(/datum/charflaw/leprosy)

/datum/aspect/negative/flaw/light_sensitive
	listable = TRUE
	flaw_type = /datum/charflaw/light_sensitive
	legacy_sources = list(/datum/charflaw/light_sensitive)

/datum/aspect/negative/flaw/lithovore
	listable = TRUE
	flaw_type = /datum/charflaw/lithovore
	conflicts = list("diet")
	tags = list("diet")
	legacy_sources = list(/datum/charflaw/lithovore)

/datum/aspect/negative/flaw/lumbering_giant
	listable = TRUE
	flaw_type = /datum/charflaw/lumbering_giant
	point_value = 0
	legacy_sources = list(/datum/charflaw/lumbering_giant)

/datum/aspect/negative/flaw/marked_by_baotha
	listable = TRUE
	flaw_type = /datum/charflaw/marked_by_baotha
	legacy_sources = list(/datum/charflaw/marked_by_baotha)

/datum/aspect/negative/flaw/masochist
	listable = TRUE
	flaw_type = /datum/charflaw/addiction/masochist
	legacy_sources = list(/datum/charflaw/addiction/masochist)

/datum/aspect/negative/flaw/nightmares
	listable = TRUE
	flaw_type = /datum/charflaw/nightmares
	legacy_sources = list(/datum/charflaw/nightmares)

/datum/aspect/negative/flaw/nymphomaniac
	listable = TRUE
	flaw_type = /datum/charflaw/addiction/lovefiend
	legacy_sources = list(/datum/charflaw/addiction/lovefiend)

/datum/aspect/negative/flaw/paranoid
	listable = TRUE
	flaw_type = /datum/charflaw/addiction/paranoid
	legacy_sources = list(/datum/charflaw/addiction/paranoid)

/datum/aspect/negative/flaw/paranoid/is_configurable()
	return TRUE

/datum/aspect/negative/flaw/paranoid/get_default_config()
	var/default_name = null
	for(var/faction_name in GLOB.averse_factions)
		default_name = faction_name
		break
	return list("faction" = GLOB.averse_factions[default_name])

/datum/aspect/negative/flaw/paranoid/describe_config(list/config)
	if(!islist(config))
		return "Not configured"
	return "Trusts: [aspect_faction_name(config["faction"])]"

/datum/aspect/negative/flaw/paranoid/validate_config(list/config, list/errors)
	if(!islist(config) || !aspect_valid_faction_flag(config["faction"]))
		LAZYADD(errors, "[name] requires a trusted faction.")
		return FALSE
	return TRUE

/datum/aspect/negative/flaw/paranoid/configure_for_profile(datum/aspect_profile/profile, datum/preferences/prefs, mob/user)
	var/list/config = profile.ensure_config(type)
	if(!islist(config))
		return FALSE
	var/current_name = aspect_faction_name(config["faction"])
	var/faction_choice = tgui_input_list(user, "Which faction do you still trust?", name, GLOB.averse_factions, current_name)
	if(!faction_choice)
		return FALSE
	config["faction"] = GLOB.averse_factions[faction_choice]
	if(prefs)
		prefs.paranoid_chosen_faction = config["faction"]
	return TRUE

/datum/aspect/negative/flaw/paranoid/apply_to_human(mob/living/carbon/human/H, datum/aspect_profile/profile)
	. = ..()
	var/list/config = profile?.get_config(type)
	if(islist(config) && H?.client?.prefs)
		H.client.prefs.paranoid_chosen_faction = config["faction"]

/datum/aspect/negative/flaw/sadist
	listable = TRUE
	flaw_type = /datum/charflaw/addiction/sadist
	legacy_sources = list(/datum/charflaw/addiction/sadist)

/datum/aspect/negative/flaw/scarred
	listable = TRUE
	flaw_type = /datum/charflaw/scarred
	legacy_sources = list(/datum/charflaw/scarred)

/datum/aspect/negative/flaw/silver_weakness
	listable = TRUE
	flaw_type = /datum/charflaw/silverweakness
	legacy_sources = list(/datum/charflaw/silverweakness)

/datum/aspect/negative/flaw/smoker
	listable = TRUE
	flaw_type = /datum/charflaw/addiction/smoker
	legacy_sources = list(/datum/charflaw/addiction/smoker)

/datum/aspect/negative/flaw/spurned
	listable = TRUE
	flaw_type = /datum/charflaw/spurned
	legacy_sources = list(/datum/charflaw/spurned)

/datum/aspect/negative/flaw/thrillseeker
	listable = TRUE
	flaw_type = /datum/charflaw/addiction/thrillseeker
	legacy_sources = list(/datum/charflaw/addiction/thrillseeker)

/datum/aspect/negative/flaw/unintelligible
	listable = TRUE
	flaw_type = /datum/charflaw/unintelligible
	conflicts = list("voice")
	tags = list("voice")
	legacy_sources = list(/datum/charflaw/unintelligible)

/datum/aspect/negative/flaw/unsettling_beauty
	listable = TRUE
	flaw_type = /datum/charflaw/unsettling_beauty
	legacy_sources = list(/datum/charflaw/unsettling_beauty)

/datum/aspect/negative/flaw/voyeur
	listable = TRUE
	flaw_type = /datum/charflaw/addiction/voyeur
	legacy_sources = list(/datum/charflaw/addiction/voyeur)

/datum/aspect/negative/flaw/carnivore
	listable = TRUE
	flaw_type = /datum/charflaw/carnivore
	conflicts = list("diet")
	tags = list("diet")
	legacy_sources = list(/datum/charflaw/carnivore)

/datum/aspect/negative/flaw/chronic_migraine
	listable = TRUE
	flaw_type = /datum/charflaw/chronic_migraine
	legacy_sources = list(/datum/charflaw/chronic_migraine)

