// Compatibility helpers for the gamemode-preset storyteller port. Ratwood's
// job scaling predates the upstream helpers, so expose the same interface over
// the local jobs without importing unrelated job/class changes.

/datum/round_event_control/proc/badomen(omen)
	return

/// AP omen update: select a weighted omen-track event without requiring the
/// normal track timer. Used for deaths that should have immediate consequences.
/proc/select_omen_event()
	var/list/candidates = list()
	var/player_count = get_active_player_count(alive_check = TRUE, afk_check = TRUE, human_check = TRUE)
	for(var/datum/round_event_control/event in SSgamemode.control)
		if(event.track != EVENT_TRACK_OMENS || event.occurrences >= event.max_occurrences)
			continue
		// State-triggered omens intentionally bypass the omen-token and earliest-
		// start gates, but still respect map landmarks, time of day, and any
		// event-specific eligibility checks.
		var/old_req_omen = event.req_omen
		var/old_earliest_start = event.earliest_start
		event.req_omen = FALSE
		event.earliest_start = 0
		var/can_spawn = event.canSpawnEvent(player_count, fake_check = TRUE)
		event.req_omen = old_req_omen
		event.earliest_start = old_earliest_start
		if(!can_spawn)
			continue
		candidates[event] = max(1, event.weight)
	if(!length(candidates))
		return null
	return pickweight(candidates)

/proc/launch_omen_event()
	var/datum/round_event_control/event = select_omen_event()
	if(!event)
		return
	if(event.announce_text)
		priority_announce(event.announce_text, event.announce_title, event.announce_sound)
	log_storyteller("State-triggered omen launching [event.name].")
	event.runEvent()

/proc/calculate_wretch_scaling(override_player_count)
	var/list/result = list()
	var/player_count = isnull(override_player_count) ? length(GLOB.joined_player_list) : override_player_count
	var/cap = SSgamemode.current_storyteller?.wretch_slot_cap
	if(!SSgamemode.allow_vote && !isnull(SSgamemode.admin_slots["Wretch"]))
		cap = max(0, SSgamemode.admin_slots["Wretch"])
	if(isnull(cap))
		cap = 10
	var/slots = min(5 + max(0, floor((player_count - 40) / 10)), cap)
	if(!SSgamemode.allow_vote && !SSgamemode.soft_scaling)
		slots = cap
	if(is_storyteller_soft_antag_blocked())
		slots = 0
	result["player_count"] = player_count
	result["cap"] = cap
	result["tier1_slots"] = slots
	result["tier2_extra"] = 0
	result["final_slots"] = slots
	result["garrison"] = SSgamemode.garrison
	result["holy_warrior"] = SSgamemode.holy_warrior
	result["acolyte"] = SSgamemode.half_combatant
	result["combat_total"] = SSgamemode.story_combat_pop()
	result["major_antag_active"] = FALSE
	return result

/proc/update_scaling_slots(override_player_count)
	var/datum/job/wretch_job = SSjob.GetJob("Wretch")
	if(wretch_job && !wretch_job.admin_slot_override)
		var/list/scaling = calculate_wretch_scaling(override_player_count)
		var/slots = max(wretch_job.current_positions, scaling["final_slots"])
		wretch_job.total_positions = slots
		wretch_job.spawn_positions = slots
	update_adventurer_slots(override_player_count)

/proc/gnollslot_calc()
	var/list/result = list("final_slots" = 0)
	if(is_storyteller_soft_antag_blocked())
		return result
	var/admin_slot = !SSgamemode.allow_vote ? SSgamemode.admin_slots["Gnoll"] : null
	if(!isnull(admin_slot))
		result["final_slots"] = max(0, admin_slot)
		return result
	if(!isnull(SSgamemode.current_storyteller?.gnoll_slot_cap))
		result["final_slots"] = max(0, SSgamemode.current_storyteller.gnoll_slot_cap)
		return result
	switch(SSgamemode.current_storyteller?.preferred_gnoll_mode)
		if(GNOLL_SCALING_SINGLE)
			result["final_slots"] = 1
		if(GNOLL_SCALING_FLAT, GNOLL_SCALING_DOUBLE)
			result["final_slots"] = 2
		if(GNOLL_SCALING_DYNAMIC)
			result["final_slots"] = 3
	return result

/proc/gnollslot_update()
	var/datum/job/gnoll_job = SSjob.GetJob("Gnoll")
	if(!gnoll_job || gnoll_job.admin_slot_override)
		return
	var/list/scaling = gnollslot_calc()
	var/slots = max(gnoll_job.current_positions, scaling["final_slots"])
	gnoll_job.total_positions = slots
	gnoll_job.spawn_positions = slots
	if(SSgnoll_scaling)
		SSgnoll_scaling.note_external_slot_adjustment(slots, slots)

/proc/calculate_adventurer_scaling(override_player_count)
	var/list/result = list()
	var/player_count = isnull(override_player_count) ? length(GLOB.joined_player_list) : override_player_count
	result["player_count"] = player_count
	var/wretch_cap = SSgamemode.current_storyteller?.wretch_slot_cap
	if(isnull(wretch_cap))
		wretch_cap = 10
	var/wretch_offset = max(0, 15 - wretch_cap)
	result["wretch_offset"] = wretch_offset
	var/slots = 30 + wretch_offset
	if(player_count > 70)
		slots += floor((player_count - 70) / 10) * 2
	result["final_slots"] = min(slots, 50 + wretch_offset)
	return result

/proc/update_adventurer_slots(override_player_count)
	var/datum/job/adventurer_job = SSjob.GetJob("Adventurer")
	if(!adventurer_job)
		return
	var/list/scaling = calculate_adventurer_scaling(override_player_count)
	var/slots = scaling["final_slots"]
	adventurer_job.total_positions = max(adventurer_job.current_positions, slots)
	adventurer_job.spawn_positions = max(adventurer_job.current_positions, slots)

// These paths/statistics do not exist in Ratwood. Keeping inert definitions
// lets the shared patron census remain source-compatible without inventing the
// missing races or gameplay flaws.
/proc/issunelf(mob/living/carbon/human/H)
	return FALSE

/proc/isvermin(mob/living/carbon/human/H)
	return FALSE

/datum/charflaw/indebted
/datum/charflaw/addiction/thrillseeker
/datum/charflaw/addiction/voyeur
/obj/item/clothing/neck/roguetown/psicross/aalloy
