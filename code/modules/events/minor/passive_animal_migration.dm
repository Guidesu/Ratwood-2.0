GLOBAL_LIST_INIT(animal_migration_points, list())

/obj/effect/landmark/events/animal_migration_point
	name = "Migration Point"

/obj/effect/landmark/events/animal_migration_point/Initialize(mapload)
	. = ..()
	GLOB.animal_migration_points += src
	icon_state = ""

/datum/round_event_control/passive_animal_migration
	name = "Passive Animal Migration"
	track = EVENT_TRACK_MUNDANE
	typepath = /datum/round_event/animal_migration/passive
	weight = 5
	max_occurrences = 4
	min_players = 0
	earliest_start = 5 MINUTES

	tags = list(
		TAG_NATURE,
		TAG_BOON,
	)

// For animals traveling into town
/datum/round_event/animal_migration
	var/list/animals = list()
	var/static/list/valid_travel_points = \
	list("bog1", "bog2", "bog3", \
	"coast", "coast2", "townouter",)


/datum/round_event/animal_migration/start()
	. = ..()
	if(length(GLOB.animal_migration_points) < 2 || !length(animals))
		return

	var/obj/effect/landmark/events/animal_migration_point/start_point = pick(GLOB.animal_migration_points)
	var/turf/start_turf = get_turf(start_point)
	var/list/end_points = GLOB.animal_migration_points.Copy()
	end_points -= start_point
	var/turf/end_turf = get_turf(pick(end_points))
	var/mob/living/simple_animal/hostile/retaliate/rogue/animal = pick(animals)
	if(!start_turf || !end_turf || !ispath(animal, /mob/living))
		return
	for(var/i = 1 to rand(3, 5))
		var/mob/living/simple_animal/hostile/retaliate/rogue/created = new animal(start_turf)
		if(created.ai_controller)
			created.ai_controller.set_blackboard_key(BB_WANDER_POINT, end_turf)
			var/list/ai_controller_paths = list()
			for(var/datum/ai_planning_subtree/tree as anything in created.ai_controller.planning_subtrees)
				ai_controller_paths |= tree.type
			ai_controller_paths |= /datum/ai_planning_subtree/travel_to_point/and_clear_target/wander
			created.ai_controller.replace_planning_subtrees(ai_controller_paths)
		else
			created.GiveTarget(end_turf)

/datum/round_event_control/passive_animal_migration/canSpawnEvent(players_amt, gamemode, fake_check)
	if(length(GLOB.animal_migration_points) < 2)
		return FALSE
	return ..()

/datum/round_event/animal_migration/passive
	animals = list(
		/mob/living/simple_animal/hostile/retaliate/rogue/cow,
		/mob/living/simple_animal/hostile/retaliate/rogue/bull,
		/mob/living/simple_animal/hostile/retaliate/rogue/chicken,
		/mob/living/simple_animal/hostile/retaliate/rogue/trufflepig,
		/mob/living/simple_animal/hostile/retaliate/rogue/goat,
		/mob/living/simple_animal/hostile/retaliate/rogue/saiga,
	)
