/datum/aspect/neutral/body_bias
	listable = TRUE
	name = "Body Bias"
	desc = "Tune your body toward one kind of harm while leaving it worse at another. Useful, but never a free upgrade."
	category = "Physical"
	kind = ASPECT_NEUTRAL
	point_value = 0
	tags = list("biology", "resistance")

/datum/aspect/neutral/body_bias/is_configurable()
	return TRUE

/datum/aspect/neutral/body_bias/get_default_config()
	return list(
		"resist_type" = "brute",
		"weak_type" = "burn",
		"strength" = "mild",
	)

/datum/aspect/neutral/body_bias/proc/get_damage_options()
	return list(
		"Brute" = "brute",
		"Burn" = "burn",
		"Toxin" = "toxin",
		"Oxygen" = "oxy",
	)

/datum/aspect/neutral/body_bias/proc/get_strength_options()
	return list(
		"Mild (0.90 resist / 1.10 weakness)" = "mild",
		"Marked (0.85 resist / 1.20 weakness)" = "marked",
	)

/datum/aspect/neutral/body_bias/proc/get_strength_multipliers(strength)
	if(strength == "marked")
		return list("resist" = 0.85, "weak" = 1.20)
	return list("resist" = 0.90, "weak" = 1.10)

/datum/aspect/neutral/body_bias/describe_config(list/config)
	if(!islist(config))
		return "Not configured"
	var/resist_type = config["resist_type"]
	var/weak_type = config["weak_type"]
	var/list/mults = get_strength_multipliers(config["strength"])
	return "[aspect_damage_label(resist_type)] x[mults["resist"]], [aspect_damage_label(weak_type)] x[mults["weak"]]"

/datum/aspect/neutral/body_bias/validate_config(list/config, list/errors)
	if(!islist(config))
		LAZYADD(errors, "[name] is missing its configuration.")
		return FALSE
	if(!(config["resist_type"] in list("brute", "burn", "toxin", "oxy")))
		LAZYADD(errors, "[name] has an invalid resistance type.")
		return FALSE
	if(!(config["weak_type"] in list("brute", "burn", "toxin", "oxy")))
		LAZYADD(errors, "[name] has an invalid weakness type.")
		return FALSE
	if(config["resist_type"] == config["weak_type"])
		LAZYADD(errors, "[name] must trade one damage type for a different weakness.")
		return FALSE
	if(!(config["strength"] in list("mild", "marked")))
		LAZYADD(errors, "[name] has an invalid strength setting.")
		return FALSE
	return TRUE

/datum/aspect/neutral/body_bias/configure_for_profile(datum/aspect_profile/profile, datum/preferences/prefs, mob/user)
	var/list/config = profile.ensure_config(type)
	if(!islist(config))
		return FALSE
	var/list/damage_options = get_damage_options()
	var/list/reverse_damage = list()
	for(var/label in damage_options)
		reverse_damage[damage_options[label]] = label
	var/current_resist = reverse_damage[config["resist_type"]]
	var/resist_choice = tgui_input_list(user, "Choose which damage type your body resists better.", "Body Bias", damage_options, current_resist)
	if(!resist_choice)
		return FALSE
	var/current_weak = reverse_damage[config["weak_type"]]
	var/weak_choice = tgui_input_list(user, "Choose which different damage type becomes your weakness.", "Body Bias", damage_options, current_weak)
	if(!weak_choice)
		return FALSE
	if(damage_options[resist_choice] == damage_options[weak_choice])
		to_chat(user, span_warning("Resistance and weakness must be different damage types."))
		return FALSE
	var/list/strength_options = get_strength_options()
	var/current_strength = (config["strength"] == "marked") ? "Marked (0.85 resist / 1.20 weakness)" : "Mild (0.90 resist / 1.10 weakness)"
	var/strength_choice = tgui_input_list(user, "Choose how strong the tradeoff should be.", "Body Bias", strength_options, current_strength)
	if(!strength_choice)
		return FALSE
	config["resist_type"] = damage_options[resist_choice]
	config["weak_type"] = damage_options[weak_choice]
	config["strength"] = strength_options[strength_choice]
	return TRUE

/datum/aspect/neutral/body_bias/apply_to_human(mob/living/carbon/human/H, datum/aspect_profile/profile)
	. = ..()
	var/list/config = profile?.get_config(type)
	if(!islist(config))
		return
	var/list/mults = get_strength_multipliers(config["strength"])
	apply_aspect_damage_bias(H, config["resist_type"], mults["resist"])
	apply_aspect_damage_bias(H, config["weak_type"], mults["weak"])

