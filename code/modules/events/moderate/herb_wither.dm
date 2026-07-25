/datum/round_event_control/herb_wither
	name = "Herb Wither"
	track = EVENT_TRACK_MODERATE
	typepath = /datum/round_event/herb_wither
	weight = 5
	max_occurrences = 8
	min_players = 0
	earliest_start = 25 MINUTES

	tags = list(
		TAG_NATURE,
		TAG_CURSE,
		TAG_ALCHEMY,
	)

/datum/round_event/herb_wither/start()
	. = ..()
	if(!length(GLOB.herb_locations))
		return
	for(var/i = 1 to rand(1, 5))
		if(!length(GLOB.herb_locations))
			break
		var/obj/structure/flora/roguegrass/herb/herb = pick(GLOB.herb_locations)
		if(!QDELETED(herb))
			qdel(herb)

/datum/round_event_control/herb_wither/canSpawnEvent(players_amt, gamemode, fake_check)
	if(!length(GLOB.herb_locations))
		return FALSE
	return ..()
