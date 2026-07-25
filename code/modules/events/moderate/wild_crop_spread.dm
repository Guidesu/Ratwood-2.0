/datum/round_event_control/wild_crops
	name = "Wild Crop Sprout"
	track = EVENT_TRACK_MODERATE
	typepath = /datum/round_event/wild_crops
	weight = 7
	max_occurrences = 10
	min_players = 0
	earliest_start = 12 MINUTES

	tags = list(
		TAG_NATURE,
		TAG_BOON,
	)

/datum/round_event/wild_crops/start()
	. = ..()
	var/list/valid_turfs = list()
	for(var/turf/turf in get_area_turfs(/area/rogue/outdoors/woods, subtypes = TRUE))
		if(istype(turf, /turf/open/floor/rogue/dirt) || istype(turf, /turf/open/floor/rogue/grass) || istype(turf, /turf/open/floor/rogue/snow))
			valid_turfs += turf
	if(!length(valid_turfs))
		return
	for(var/i = 1 to min(rand(2, 12), length(valid_turfs)))
		var/turf/turf = pick_n_take(valid_turfs)
		new /obj/structure/wild_plant(turf)

/datum/round_event_control/wild_crops/canSpawnEvent(players_amt, gamemode, fake_check)
	var/list/turfs = get_area_turfs(/area/rogue/outdoors/woods, subtypes = TRUE)
	if(!length(turfs))
		return FALSE
	return ..()
