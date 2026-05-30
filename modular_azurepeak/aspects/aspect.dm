GLOBAL_LIST_EMPTY(aspects)

#define ASPECT_POSITIVE "positive"
#define ASPECT_NEGATIVE "negative"
#define ASPECT_NEUTRAL "neutral"
#define ASPECT_SOURCE "aspect"

/datum/aspect
	var/name = "Aspect"
	var/desc = ""
	var/category = "Physical"
	var/kind = ASPECT_NEUTRAL
	var/point_value = 0
	var/list/tags = list()
	var/list/conflicts = list()
	var/list/requires = list()
	var/list/legacy_sources = list()
	var/repeatable = FALSE
	var/listable = FALSE
	var/list/added_traits = list()
	var/list/added_skills = list()
	var/list/added_stashed_items = list()
	var/flaw_type
	var/virtue_type

/datum/aspect/proc/can_select(datum/preferences/prefs)
	return TRUE

/datum/aspect/proc/is_configurable()
	return FALSE

/datum/aspect/proc/get_default_config()
	return null

/datum/aspect/proc/describe_config(list/config)
	return null

/datum/aspect/proc/validate_config(list/config, list/errors)
	return TRUE

/datum/aspect/proc/configure_for_profile(datum/aspect_profile/profile, datum/preferences/prefs, mob/user)
	return FALSE

/datum/aspect/proc/get_extra_summary_lines()
	return null

/datum/aspect/proc/get_display_category()
	if(kind == ASPECT_NEGATIVE)
		return "Drawbacks"
	if(category in list("Physical", "Social", "Labor", "Magicks"))
		return category
	return "Physical"

/proc/aspect_stat_label(stat_key)
	var/label = replacetext("[stat_key]", "_", " ")
	return capitalize(lowertext(label))

/proc/aspect_flaw_menu_label(flaw_type)
	for(var/flaw_label in GLOB.character_flaws)
		if(GLOB.character_flaws[flaw_label] == flaw_type)
			return flaw_label
	return null

/proc/aspect_flaw_default_points(flaw_type)
	var/flaw_label = aspect_flaw_menu_label(flaw_type)
	if(!flaw_label)
		return 1
	if(findtext(flaw_label, "(+2 TRI)"))
		return 2
	if(findtext(flaw_label, "(+1 TRI)"))
		return 1
	if(findtext(flaw_label, "(-"))
		return 0
	return 1

/proc/aspect_flaw_default_category(flaw_type)
	var/path_text = "[flaw_type]"
	if(findtext(path_text, "/addiction/godfearing") || findtext(path_text, "/spurned") || findtext(path_text, "/marked_by_baotha") || findtext(path_text, "/mind_broken"))
		return "Magicks"
	if(findtext(path_text, "/addiction/") || findtext(path_text, "/averse") || findtext(path_text, "/isolationist") || findtext(path_text, "/clingy") || findtext(path_text, "/finicky") || findtext(path_text, "/greedy") || findtext(path_text, "/hunted") || findtext(path_text, "/indebted") || findtext(path_text, "/ugly") || findtext(path_text, "/annoying_face") || findtext(path_text, "/scarred") || findtext(path_text, "/unsettling_beauty") || findtext(path_text, "/disgraced_noble") || findtext(path_text, "/illiterate"))
		return "Social"
	return "Physical"

/proc/aspect_strip_tags(text)
	var/output = "[text]"
	var/start = findtext(output, "<")
	while(start)
		var/finish = findtext(output, ">", start)
		if(!finish)
			break
		output = copytext(output, 1, start) + copytext(output, finish + 1)
		start = findtext(output, "<")
	return output

/proc/aspect_skill_display_name(skill_type)
	if(!skill_type)
		return null
	var/datum/skill/skill_ref = SSskills?.all_skills?[skill_type]
	if(skill_ref?.name)
		return skill_ref.name
	if(ispath(skill_type, /datum/skill))
		var/datum/skill/temp_skill = new skill_type
		. = temp_skill?.name
		qdel(temp_skill)
		return .
	return "[skill_type]"

/proc/aspect_trait_detail_lines(list/trait_list)
	if(!LAZYLEN(trait_list))
		return null
	var/list/details = list()
	for(var/trait_name in trait_list)
		var/trait_desc = GLOB.roguetraits?[trait_name]
		if(!trait_desc)
			continue
		trait_desc = aspect_strip_tags("[trait_desc]")
		trait_desc = trim(trait_desc)
		if(!length(trait_desc))
			continue
		if(!(trait_desc in details))
			details += trait_desc
	if(!LAZYLEN(details))
		return null
	if(LAZYLEN(details) > 2)
		details.Cut(3)
	return details

/datum/aspect/proc/get_skill_summary(list/skill_list)
	if(!LAZYLEN(skill_list))
		return null
	var/list/chunks = list()
	for(var/skill_entry in skill_list)
		var/skill_type = skill_entry
		var/skill_delta = skill_list[skill_entry]
		var/skill_name = "[skill_type]"
		if(ispath(skill_entry, /datum/skill))
			skill_name = aspect_skill_display_name(skill_entry) || "[skill_entry]"
		else if(islist(skill_entry))
			var/list/skill_block = skill_entry
			var/skill_path = skill_block[1]
			skill_name = aspect_skill_display_name(skill_path) || "[skill_path]"
			skill_delta = skill_block[2]
		if(isnum(skill_delta))
			chunks += "[skill_name] +[skill_delta]"
		else
			chunks += "[skill_name]"
	return LAZYLEN(chunks) ? english_list(chunks) : null

/datum/aspect/proc/get_item_summary(list/item_list)
	if(!LAZYLEN(item_list))
		return null
	var/list/item_names = list()
	for(var/item_name in item_list)
		item_names += "[item_name]"
	return LAZYLEN(item_names) ? english_list(item_names) : null

/datum/aspect/proc/get_stat_summary(list/stat_list)
	if(!LAZYLEN(stat_list))
		return null
	var/list/chunks = list()
	for(var/stat_key in stat_list)
		var/value = stat_list[stat_key]
		if(isnum(value))
			chunks += "[aspect_stat_label(stat_key)] [value > 0 ? "+" : ""][value]"
		else
			chunks += "[aspect_stat_label(stat_key)]"
	return LAZYLEN(chunks) ? english_list(chunks) : null

/datum/aspect/proc/get_trait_summary(list/trait_list)
	if(!LAZYLEN(trait_list))
		return null
	var/list/chunks = list()
	for(var/trait_name in trait_list)
		chunks += "[trait_name]"
	return LAZYLEN(chunks) ? english_list(chunks) : null

/datum/aspect/proc/get_effect_summary_lines()
	var/list/lines = list()
	var/trait_text = get_trait_summary(added_traits)
	if(trait_text)
		lines += "Traits: [trait_text]"
	var/list/trait_details = aspect_trait_detail_lines(added_traits)
	if(LAZYLEN(trait_details))
		for(var/trait_detail in trait_details)
			lines += "Effect: [trait_detail]"
	var/skill_text = get_skill_summary(added_skills)
	if(skill_text)
		lines += "Skills: [skill_text]"
	var/item_text = get_item_summary(added_stashed_items)
	if(item_text)
		lines += "Items: [item_text]"
	if(virtue_type)
		var/datum/virtue/V = GLOB.virtues[virtue_type]
		if(V)
			var/virtue_trait_text = get_trait_summary(V.added_traits)
			if(virtue_trait_text)
				lines += "Traits: [virtue_trait_text]"
			var/list/virtue_trait_details = aspect_trait_detail_lines(V.added_traits)
			if(LAZYLEN(virtue_trait_details))
				for(var/virtue_trait_detail in virtue_trait_details)
					lines += "Effect: [virtue_trait_detail]"
			var/virtue_skill_text = get_skill_summary(V.added_skills)
			if(virtue_skill_text)
				lines += "Skills: [virtue_skill_text]"
			var/virtue_item_text = get_item_summary(V.added_stashed_items)
			if(virtue_item_text)
				lines += "Items: [virtue_item_text]"
			var/virtue_stat_text = get_stat_summary(V.added_stats)
			if(virtue_stat_text)
				lines += "Stats: [virtue_stat_text]"
			if(V.custom_text)
				lines += "[V.custom_text]"
	var/list/extra_lines = get_extra_summary_lines()
	if(LAZYLEN(extra_lines))
		lines += extra_lines
	return lines

/datum/aspect/proc/apply_to_human(mob/living/carbon/human/H, datum/aspect_profile/profile)
	if(virtue_type)
		var/datum/virtue/V = new virtue_type()
		V.apply_to_human(H)
		V.handle_traits(H)
		V.handle_skills(H)
		V.handle_stashed_items(H)
		V.handle_added_languages(H)
		V.handle_stats(H)
		record_featured_object_stat(FEATURED_STATS_VIRTUES, V.name)
	if(flaw_type)
		var/datum/charflaw/flaw = new flaw_type()
		H.vices += flaw
		if(!H.charflaw)
			H.charflaw = flaw
		flaw.on_mob_creation(H)
	for(var/trait in added_traits)
		ADD_TRAIT(H, trait, ASPECT_SOURCE)

/datum/aspect/proc/apply_post_equipment(mob/living/carbon/human/H, datum/aspect_profile/profile)
	if(flaw_type)
		var/datum/charflaw/flaw = locate(flaw_type) in H.vices
		if(flaw)
			flaw.apply_post_equipment(H)
			record_featured_object_stat(FEATURED_STATS_VICES, flaw.name)
	for(var/skill in added_skills)
		H.adjust_skillrank(skill, added_skills[skill], TRUE)
	for(var/item_name in added_stashed_items)
		H.mind?.special_items[item_name] = added_stashed_items[item_name]

/datum/aspect/proc/on_life(mob/living/carbon/human/H)
	return

/datum/aspect/proc/on_removal(mob/living/carbon/human/H)
	if(flaw_type)
		var/datum/charflaw/flaw = locate(flaw_type) in H.vices
		if(flaw)
			flaw.on_removal(H)
			H.vices -= flaw
			qdel(flaw)
	for(var/trait in added_traits)
		REMOVE_TRAIT(H, trait, ASPECT_SOURCE)

/proc/remap_legacy_aspect_type(aspect_type)
	var/path_text = "[aspect_type]"
	switch(path_text)
		if("/datum/aspect/neutral/nudist")
			return /datum/aspect/negative/flaw/nudist
		if("/datum/aspect/neutral/nude_sleeper")
			return /datum/aspect/negative/flaw/nude_sleeper
		if("/datum/aspect/neutral/devout_follower")
			return /datum/aspect/negative/flaw/devout_follower
		if("/datum/aspect/neutral/isolationist")
			return /datum/aspect/negative/flaw/isolationist
		if("/datum/aspect/neutral/finicky")
			return /datum/aspect/negative/flaw/finicky
		if("/datum/aspect/neutral/greedy")
			return /datum/aspect/negative/flaw/greedy
	return aspect_type

/datum/aspect_profile
	var/list/selected_aspects = list()
	var/list/aspect_configs = list()

/datum/aspect_profile/proc/has_active_aspects()
	sanitize()
	return LAZYLEN(selected_aspects) > 0

/datum/aspect_profile/proc/sanitize()
	var/list/sanitized = list()
	if(!islist(selected_aspects))
		selected_aspects = list()
	if(!islist(aspect_configs))
		aspect_configs = list()
		return
	for(var/aspect_entry in selected_aspects)
		var/aspect_type = normalize_aspect_path(aspect_entry)
		if(!aspect_type || !GLOB.aspects[aspect_type])
			continue
		if(aspect_type in sanitized)
			continue
		sanitized += aspect_type
	selected_aspects = sanitized
	var/list/sanitized_configs = list()
	if(!islist(aspect_configs))
		aspect_configs = list()
	for(var/config_key in aspect_configs)
		var/aspect_type = normalize_aspect_path(config_key)
		if(!aspect_type || !(aspect_type in selected_aspects))
			continue
		var/list/config = aspect_configs[config_key]
		if(islist(config))
			sanitized_configs[aspect_type] = deep_copy_aspect_config(config)
	aspect_configs = sanitized_configs

/datum/aspect_profile/proc/deep_copy_aspect_config(list/config)
	if(!islist(config))
		return null
	var/list/copied = list()
	for(var/key in config)
		if(islist(config[key]))
			copied[key] = deep_copy_aspect_config(config[key])
		else
			copied[key] = config[key]
	return copied

/datum/aspect_profile/proc/get_config(aspect_type)
	aspect_type = normalize_aspect_path(aspect_type)
	if(!aspect_type)
		return null
	var/list/config = aspect_configs?[aspect_type]
	if(islist(config))
		return config
	return null

/datum/aspect_profile/proc/ensure_config(aspect_type)
	aspect_type = normalize_aspect_path(aspect_type)
	if(!aspect_type)
		return null
	var/datum/aspect/A = GLOB.aspects[aspect_type]
	if(!A?.is_configurable())
		return null
	if(!islist(aspect_configs))
		aspect_configs = list()
	if(!islist(aspect_configs[aspect_type]))
		var/list/default_config = A.get_default_config()
		aspect_configs[aspect_type] = islist(default_config) ? deep_copy_aspect_config(default_config) : list()
	return aspect_configs[aspect_type]

/datum/aspect_profile/proc/normalize_aspect_path(aspect_entry)
	if(istype(aspect_entry, /datum/aspect))
		var/datum/aspect/A = aspect_entry
		return remap_legacy_aspect_type(A.type)
	var/aspect_type = string_to_typepath(aspect_entry)
	if(!aspect_type && ispath(aspect_entry, /datum/aspect))
		aspect_type = aspect_entry
	aspect_type = remap_legacy_aspect_type(aspect_type)
	if(ispath(aspect_type, /datum/aspect))
		return aspect_type
	return null

/datum/aspect_profile/proc/get_aspects()
	sanitize()
	var/list/aspects = list()
	for(var/aspect_type in selected_aspects)
		var/datum/aspect/A = GLOB.aspects[aspect_type]
		if(A)
			aspects += A
	return aspects

/datum/aspect_profile/proc/get_raw_negative_points()
	var/points = 0
	for(var/datum/aspect/A in get_aspects())
		if(A.kind == ASPECT_NEGATIVE)
			points += max(A.point_value, 0)
	return points

/datum/aspect_profile/proc/get_negative_credit()
	var/raw = get_raw_negative_points()
	var/full = min(raw, 6)
	var/half = min(max(raw - 6, 0), 6)
	return full + round(half / 2)

/datum/aspect_profile/proc/get_positive_cost(datum/preferences/prefs)
	var/cost = 0
	for(var/datum/aspect/A in get_aspects())
		if(A.kind == ASPECT_POSITIVE)
			cost += max(A.point_value, 0)
	return cost

/datum/aspect_profile/proc/get_balance(datum/preferences/prefs)
	return (prefs?.get_base_aspect_points() || 0) + get_negative_credit() - get_positive_cost(prefs)

/datum/aspect_profile/proc/validate(datum/preferences/prefs, list/errors)
	sanitize()
	var/list/seen_tags = list()
	var/list/seen_types = list()
	var/valid = TRUE
	for(var/datum/aspect/A in get_aspects())
		if(!A.repeatable && (A.type in seen_types))
			LAZYADD(errors, "[A.name] cannot be selected more than once.")
			valid = FALSE
		seen_types += A.type
		if(!A.can_select(prefs))
			LAZYADD(errors, "[A.name] is not available to this character.")
			valid = FALSE
		if(A.is_configurable())
			var/list/config = ensure_config(A.type)
			if(!A.validate_config(config, errors))
				valid = FALSE
		for(var/required in A.requires)
			if(ispath(required, /datum/aspect) && !(required in selected_aspects))
				var/datum/aspect/required_aspect = GLOB.aspects[required]
				LAZYADD(errors, "[A.name] requires [required_aspect?.name || required].")
				valid = FALSE
			else if(istext(required) && !(required in seen_tags))
				LAZYADD(errors, "[A.name] requires another selected aspect tagged [required].")
				valid = FALSE
		for(var/conflict in A.conflicts)
			if(ispath(conflict, /datum/aspect) && (conflict in selected_aspects))
				var/datum/aspect/conflict_aspect = GLOB.aspects[conflict]
				LAZYADD(errors, "[A.name] conflicts with [conflict_aspect?.name || conflict].")
				valid = FALSE
			else if(istext(conflict) && (conflict in seen_tags))
				LAZYADD(errors, "[A.name] conflicts with another selected aspect tagged [conflict].")
				valid = FALSE
		for(var/tag in A.tags)
			if(tag in seen_tags)
				continue
			seen_tags += tag
	var/balance = get_balance(prefs)
	if(balance < 0)
		LAZYADD(errors, "Aspect budget is overspent by [abs(balance)] point\s.")
		valid = FALSE
	return valid

/datum/aspect_profile/proc/can_toggle(aspect_type, datum/preferences/prefs, list/errors)
	aspect_type = normalize_aspect_path(aspect_type)
	if(!aspect_type || !GLOB.aspects[aspect_type])
		LAZYADD(errors, "Invalid aspect.")
		return FALSE
	if(aspect_type in selected_aspects)
		return TRUE
	var/list/test_selection = selected_aspects.Copy()
	test_selection += aspect_type
	var/datum/aspect_profile/test_profile = new()
	test_profile.selected_aspects = test_selection
	return test_profile.validate(prefs, errors)

/datum/aspect_profile/proc/toggle(aspect_type, datum/preferences/prefs, mob/user)
	aspect_type = normalize_aspect_path(aspect_type)
	if(!aspect_type || !GLOB.aspects[aspect_type])
		return FALSE
	if(aspect_type in selected_aspects)
		aspect_configs -= aspect_type
		selected_aspects -= aspect_type
		return TRUE
	var/list/errors = list()
	if(!can_toggle(aspect_type, prefs, errors))
		if(user && LAZYLEN(errors))
			to_chat(user, span_warning(errors[1]))
		return FALSE
	selected_aspects += aspect_type
	var/datum/aspect/A = GLOB.aspects[aspect_type]
	if(A?.is_configurable())
		ensure_config(aspect_type)
	return TRUE

/datum/aspect_profile/proc/clear()
	selected_aspects = list()
	aspect_configs = list()

/datum/aspect_profile/proc/import_legacy_choices(datum/preferences/prefs)
	clear()
	if(prefs?.virtue && prefs.virtue.type != /datum/virtue/none)
		add_legacy_source(prefs.virtue.type)
	if(prefs?.virtuetwo && prefs.virtuetwo.type != /datum/virtue/none)
		add_legacy_source(prefs.virtuetwo.type)
	for(var/datum/virtue/feat in prefs?.feats)
		if(feat)
			add_legacy_source(feat.type)
	for(var/i = 1 to 8)
		var/datum/charflaw/vice = prefs?.vars["vice[i]"]
		if(vice)
			add_legacy_source(vice.type)
	sanitize()

/datum/aspect_profile/proc/add_legacy_source(source_type)
	for(var/aspect_type in GLOB.aspects)
		var/datum/aspect/A = GLOB.aspects[aspect_type]
		if(!A?.listable)
			continue
		if(source_type in A.legacy_sources)
			if(!(A.type in selected_aspects))
				selected_aspects += A.type

/proc/apply_aspect_damage_bias(mob/living/carbon/human/H, damage_type, multiplier)
	if(!H?.physiology || !isnum(multiplier) || multiplier <= 0)
		return
	switch(damage_type)
		if("brute")
			H.physiology.brute_mod *= multiplier
		if("burn")
			H.physiology.burn_mod *= multiplier
		if("toxin")
			H.physiology.tox_mod *= multiplier
		if("oxy")
			H.physiology.oxy_mod *= multiplier

/proc/aspect_damage_label(damage_type)
	switch(damage_type)
		if("brute")
			return "Brute"
		if("burn")
			return "Burn"
		if("toxin")
			return "Toxin"
		if("oxy")
			return "Oxygen"
	return "Unknown"

/datum/aspect_profile/proc/apply_to_human(mob/living/carbon/human/H)
	for(var/datum/aspect/A in get_aspects())
		A.apply_to_human(H, src)

/datum/aspect_profile/proc/apply_post_equipment(mob/living/carbon/human/H)
	for(var/datum/aspect/A in get_aspects())
		A.apply_post_equipment(H, src)

/datum/preferences/proc/ensure_aspect_profile()
	if(!aspect_profile)
		aspect_profile = new()
	aspect_profile.sanitize()
	return aspect_profile

/datum/preferences/proc/aspects_are_supported_for(mob/living/carbon/human/H)
	if(!H)
		return FALSE
	var/datum/job/job = H.job ? SSjob.name_occupations[H.job] : null
	if(!job && H.mind?.assigned_role)
		job = SSjob.GetJob(H.mind.assigned_role)
	if(istype(job, /datum/job/roguetown/adventurer))
		return TRUE
	if(istype(job, /datum/job/roguetown/villager))
		return TRUE
	if(istype(job, /datum/job/roguetown/pilgrim))
		return TRUE
	if(H.job in list("Adventurer", "Towner", "Refugee"))
		return TRUE
	return FALSE

/datum/preferences/proc/should_apply_aspects(mob/living/carbon/human/H)
	var/datum/aspect_profile/profile = ensure_aspect_profile()
	if(!profile.has_active_aspects())
		return FALSE
	var/list/errors = list()
	if(!profile.validate(src, errors))
		return FALSE
	return aspects_are_supported_for(H)

/datum/preferences/proc/get_base_aspect_points()
	if(statpack?.name == "Virtuous")
		return 5
	return 0

/datum/aspect/positive
	kind = ASPECT_POSITIVE

/datum/aspect/negative
	kind = ASPECT_NEGATIVE

/datum/aspect/neutral
	kind = ASPECT_NEUTRAL
	point_value = 0

