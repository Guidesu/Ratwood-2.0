/datum/round_event_control/town_fire
	name = "Town Fire"
	track = EVENT_TRACK_MODERATE
	typepath = /datum/round_event/town_fire
	weight = 3
	max_occurrences = 2
	min_players = 0
	earliest_start = 25 MINUTES

	tags = list(
		TAG_WORK,
		TAG_CURSE,
		TAG_WIDESPREAD,
	)

/datum/round_event/town_fire/start()
	. = ..()
	var/list/turfs = get_area_turfs(/area/rogue/indoors/town, subtypes = TRUE)
	if(!length(turfs))
		return
	for(var/i = 1 to min(rand(2, 5), length(turfs)))
		var/turf/turf = pick_n_take(turfs)
		if(turf)
			new /obj/effect/hotspot(turf)

/datum/round_event_control/town_fire/canSpawnEvent(players_amt, gamemode, fake_check)
	if(!length(get_area_turfs(/area/rogue/indoors/town, subtypes = TRUE)))
		return FALSE
	return ..()
