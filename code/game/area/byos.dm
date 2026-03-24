/area/rogue/outdoors/jungle
	name = "The Jungle of Dread"
	icon_state = "bog"
	warden_area = TRUE
	ambientsounds = AMB_BOGDAY
	ambientnight = AMB_BOGNIGHT
	spookysounds = SPOOKY_FROG
	spookynight = SPOOKY_GEN
	droning_sound = 'sound/music/area/bog.ogg'
	droning_sound_dusk = null
	droning_sound_night = null
	ambush_times = list("night","dawn","dusk","day")
	ambush_mobs = list(
				/mob/living/simple_animal/hostile/retaliate/rogue/troll/bog = 20,
				/mob/living/simple_animal/hostile/retaliate/rogue/spider = 40,
				/mob/living/carbon/human/species/skeleton/npc/bogguard = 20,
				/mob/living/carbon/human/species/goblin/npc/ambush/cave = 30,
				new /datum/ambush_config/bog_guard_deserters = 50,		
				new /datum/ambush_config/bog_guard_deserters/hard = 25,
				new /datum/ambush_config/mirespiders_ambush = 110,
				new /datum/ambush_config/mirespiders_crawlers = 25,
				new /datum/ambush_config/mirespiders_aragn = 10,
				new /datum/ambush_config/mirespiders_unfair = 5)
	first_time_text = "THE DREAD JUNGLE"
	converted_type = /area/rogue/indoors/shelter/jungle
	threat_region = THREAT_REGION_TERRORBOG
	deathsight_message = "a wretched, sweltering jungle"
	// detail_text = DETAIL_TEXT_TERRORBOG

/area/rogue/indoors/shelter/jungle
	icon_state = "bog"
	droning_sound = 'sound/music/area/bog.ogg'
	droning_sound_dusk = null
	droning_sound_night = null
	deathsight_message = "a wretched, sweltering jungle"

	
/area/rogue/outdoors/rtfield/byos
	name = "New-Kingsfield wilderness"
	first_time_text = null
	threat_region = THREAT_REGION_ROCKHILL_BASIN
	town_area = TRUE

// /area/rogue/outdoors/jungle/west
// 	name = "Eastern Dread-Jungle"

// /area/rogue/outdoors/jungle/east
// 	name = "Western Dread-Jungle"

/area/rogue/outdoors/town/byos
	name = "outdoors"
	first_time_text = "The Colony of New Kingsfield"
	town_area = TRUE
	deathsight_message = "the colony of New Kingsfield and all its bustling souls"

/area/rogue/indoors/banditcamp/byos
	name = "Pirate's Ship"
	// droning_sound = 'sound/music/area/banditcamp.ogg'
	// droning_sound_dusk = 'sound/music/area/banditcamp.ogg'
	// droning_sound_night = 'sound/music/area/banditcamp.ogg'
	deathsight_message = "a hidden cove of greedy secrets"

// /area/rogue/outdoors/banditcamp/byos
// 	name = "Pirate's Cove"
// 	// droning_sound = 'sound/music/area/banditcamp.ogg'
// 	// droning_sound_dusk = 'sound/music/area/banditcamp.ogg'
// 	// droning_sound_night = 'sound/music/area/banditcamp.ogg'
// 	first_time_text = "A Gathering of Thieves"
// 	deathsight_message = "a hidden cove of greedy secrets"


/area/rogue/under/cavewet/byos
	name = "The Undergrove"
	icon_state = "cavewet"
	warden_area = TRUE
	// first_time_text = "The Undergrove"
	ambientsounds = AMB_CAVEWATER
	ambientnight = AMB_CAVEWATER
	spookysounds = SPOOKY_CAVE
	spookynight = SPOOKY_CAVE
	droning_sound = 'sound/music/area/caves.ogg'
	droning_sound_dusk = null
	droning_sound_night = null
	ambush_times = list("night","dawn","dusk","day")
	ambush_mobs = list(
				/mob/living/carbon/human/species/skeleton/npc/easy = 10,
				/mob/living/simple_animal/hostile/retaliate/rogue/bigrat = 30,
				/mob/living/carbon/human/species/goblin/npc/sea = 20,
				/mob/living/carbon/human/species/human/northern/highwayman/ambush = 20,
				/mob/living/simple_animal/hostile/retaliate/rogue/troll = 15)
	// converted_type = /area/rogue/outdoors/caves
	deathsight_message = "salt-soaked caverns"
	// detail_text = DETAIL_TEXT_UNDERGROVE

	
/area/rogue/under/cavewet/byos/banditcove
	first_time_text = "A Gathering of Thieves"
	deathsight_message = "a hidden cove of greedy secrets"
	droning_sound = 'sound/music/area/banditcamp.ogg'
	droning_sound_dusk = 'sound/music/area/banditcamp.ogg'
	droning_sound_night = 'sound/music/area/banditcamp.ogg'
	ambush_times = null





// /area/rogue/indoors
// 	name = "indoors rt"
// 	icon_state = "indoors"
// 	ambientrain = RAIN_IN
// 	ambientsounds = AMB_INGEN
// 	ambientnight = AMB_INGEN
// 	spookysounds = SPOOKY_GEN
// 	spookynight = SPOOKY_GEN
// 	droning_sound = 'sound/music/area/towngen.ogg'
// 	droning_sound_dusk = 'sound/music/area/septimus.ogg'
// 	droning_sound_night = 'sound/music/area/sleeping.ogg'
// 	soundenv = 2
// 	plane = INDOOR_PLANE
// 	converted_type = /area/rogue/outdoors

///// OUTDOORS AREAS //////

// /area/rogue/outdoors
// 	name = "Outdoors Roguetown"
// 	icon_state = "outdoors"
// 	outdoors = TRUE
// 	ambientrain = RAIN_OUT
// //	ambientsounds = list('sound/ambience/wamb.ogg')
// 	ambientsounds = AMB_TOWNDAY
// 	ambientnight = AMB_TOWNNIGHT
// 	spookysounds = SPOOKY_CROWS
// 	spookynight = SPOOKY_GEN
// 	droning_sound = 'sound/music/area/townstreets.ogg'
// 	droning_sound_dusk = 'sound/music/area/septimus.ogg'
// 	droning_sound_night = 'sound/music/area/sleeping.ogg'
// 	converted_type = /area/rogue/indoors/shelter
// 	soundenv = 16
// 	deathsight_message = "somewhere in the wilds"


// /area/rogue/indoors/shelter
// 	icon_state = "shelter"
// 	droning_sound = 'sound/music/area/townstreets.ogg'
// 	droning_sound_dusk = 'sound/music/area/septimus.ogg'
// 	droning_sound_night = 'sound/music/area/sleeping.ogg'
// 	deathsight_message = "somewhere in the wilds, under a roof"

// /area/rogue/outdoors/mountains
// 	name = "Mountains"
// 	icon_state = "mountains"
// 	ambientsounds = AMB_MOUNTAIN
// 	ambientnight = AMB_MOUNTAIN
// 	spookysounds = SPOOKY_GEN
// 	spookynight = SPOOKY_GEN
// 	droning_sound = 'sound/music/area/townstreets.ogg'
// 	droning_sound_dusk = 'sound/music/area/septimus.ogg'
// 	droning_sound_night = 'sound/music/area/sleeping.ogg'
// 	warden_area = TRUE
// 	soundenv = 17
// 	converted_type = /area/rogue/indoors/shelter/mountains
// 	deathsight_message = "a twisted tangle of soaring peaks"
// 	// I SURE HOPE NO ONE USE THIS HUH

// /area/rogue/outdoors/rtfield
// 	name = "Rotwood Basin"
// 	icon_state = "rtfield"
// 	soundenv = 19
// 	ambush_times = list("night")
// 	ambush_mobs = list(
// 				/mob/living/simple_animal/hostile/retaliate/rogue/wolf/badger = 10,
// 				/mob/living/simple_animal/hostile/retaliate/rogue/wolf/raccoon = 25,
// 				/mob/living/simple_animal/hostile/retaliate/rogue/wolf/bobcat = 20,
// 				/mob/living/simple_animal/hostile/retaliate/rogue/wolf = 30,
// 				/mob/living/simple_animal/hostile/retaliate/rogue/fox = 30,
// 				/mob/living/carbon/human/species/skeleton/npc/supereasy = 30)
// 	first_time_text = "ROTWOOD BASIN"
// 	droning_sound = 'sound/music/area/field.ogg'
// 	droning_sound_dusk = 'sound/music/area/septimus.ogg'
// 	droning_sound_night = 'sound/music/area/sleeping.ogg'
// 	converted_type = /area/rogue/indoors/shelter/rtfield
// 	deathsight_message = "somewhere in the wilds, next to towering walls"
// 	warden_area = TRUE
// 	threat_region = THREAT_REGION_AZURE_BASIN

// /area/rogue/outdoors/rtfield/rockhill
// 	first_time_text = "Rockhill Basin"
// 	threat_region = THREAT_REGION_ROCKHILL_BASIN
// 	town_area = TRUE

// /area/rogue/outdoors/rtfield/rockhill/above
// 	ambientsounds = AMB_MOUNTAIN
// 	ambientnight = AMB_MOUNTAIN
// 	soundenv = 17

// /area/rogue/indoors/shelter/rtfield
// 	icon_state = "rtfield"
// 	droning_sound = 'sound/music/area/field.ogg'
// 	droning_sound_dusk = 'sound/music/area/septimus.ogg'
// 	droning_sound_night = 'sound/music/area/sleeping.ogg'

// //// UNDER AREAS (no indoor rain sound usually)

// // these don't get a rain sound because they're underground
// /area/rogue/under
// 	name = "basement"
// 	icon_state = "under"
// 	droning_sound = 'sound/music/area/towngen.ogg'
// 	droning_sound_dusk = 'sound/music/area/septimus.ogg'
// 	droning_sound_night = 'sound/music/area/sleeping.ogg'
// 	soundenv = 8
// 	plane = INDOOR_PLANE
// 	converted_type = /area/rogue/outdoors/exposed

// /area/rogue/outdoors/exposed
// 	icon_state = "exposed"
// 	droning_sound = 'sound/music/area/towngen.ogg'
// 	droning_sound_dusk = 'sound/music/area/septimus.ogg'
// 	droning_sound_night = 'sound/music/area/sleeping.ogg'

// /area/rogue/under/cavelava
// 	name = "cavelava"
// 	icon_state = "cavelava"
// 	first_time_text = "MOUNT DECAPITATION"
// 	ambientsounds = AMB_CAVELAVA
// 	ambientnight = AMB_CAVELAVA
// 	spookysounds = SPOOKY_CAVE
// 	spookynight = SPOOKY_CAVE
// 	ambush_times = list("night","dawn","dusk","day")
// 	ambush_mobs = list(
// 				/mob/living/simple_animal/hostile/retaliate/rogue/bigrat = 10,
// 				/mob/living/carbon/human/species/skeleton/npc/ambush = 20,
// 				/mob/living/carbon/human/species/goblin/npc/hell = 25,
// 				/mob/living/simple_animal/hostile/retaliate/rogue/minotaur = 15)
// 	droning_sound = 'sound/music/area/decap.ogg'
// 	droning_sound_dusk = null
// 	droning_sound_night = null
// 	converted_type = /area/rogue/outdoors/exposed/decap

// /area/rogue/outdoors/exposed/decap
// 	icon_state = "decap"
// 	droning_sound = 'sound/music/area/decap.ogg'
// 	droning_sound_dusk = null
// 	droning_sound_night = null

// /area/rogue/under/lake
// 	name = "underground lake"
// 	icon_state = "lake"
// 	ambientsounds = AMB_BEACH
// 	ambientnight = AMB_BEACH
// 	spookysounds = SPOOKY_CAVE
// 	spookynight = SPOOKY_GEN

// /area/rogue/under/cave/dungeon1
// 	name = "smalldungeon1"
// 	icon_state = "spider"
// 	droning_sound = 'sound/music/area/dungeon.ogg'
// 	droning_sound_dusk = null
// 	droning_sound_night = null
// 	converted_type = /area/rogue/outdoors/dungeon1

// /area/rogue/under/cave/licharena
// 	name = "lich's domain"
// 	icon_state = "under"
// 	first_time_text = "LICH'S DOMAIN"
// 	droning_sound = 'sound/music/area/dragonden.ogg'
// 	droning_sound_dusk = null
// 	droning_sound_night = null
// 	converted_type = /area/rogue/outdoors/dungeon1
// 	ceiling_protected = TRUE
// 	detail_text = DETAIL_TEXT_LICH_DOMAIN

// /area/rogue/under/cave/licharena/bossroom
// 	name = "the lich's lair"
// 	first_time_text = "THE LICH"

// /area/rogue/under/cave/licharena/bossroom/can_craft_here()
// 	return FALSE

// /area/rogue/under/cave/undeadmanor
// 	name = "skelemansion"
// 	icon_state = "spidercave"
// 	first_time_text = "ABANDONED MANOR"
// 	droning_sound = 'sound/music/area/dungeon2.ogg'
// 	droning_sound_dusk = null
// 	droning_sound_night = null
// 	converted_type = /area/rogue/outdoors/dungeon1
// 	ceiling_protected = TRUE

// /area/rogue/under/cave/inferno
// 	name = "inferno"
// 	icon_state = "fire_chamber"
// 	first_time_text = "Somewhere Else..."
// 	droning_sound = 'sound/music/area/inferno.ogg'
// 	droning_sound_dusk = null
// 	droning_sound_night = null
// 	converted_type = /area/rogue/outdoors/dungeon1
// 	ceiling_protected = TRUE

// /area/rogue/outdoors/dungeon1
// 	name = "smalldungeonoutdoors"
// 	icon_state = "spidercave"
// 	droning_sound = 'sound/music/area/dungeon.ogg'
// 	droning_sound_dusk = null
// 	droning_sound_night = null
// 	ceiling_protected = TRUE

// /area/rogue/under/cave/inhumen
// 	name = "inhumen"
// 	icon_state = "cave"
// 	first_time_text = "FORSAKEN CATHEDRAL"
// 	droning_sound = 'sound/music/unholy.ogg'
// 	droning_sound_dusk = 'sound/music/unholy.ogg'
// 	droning_sound_night = 'sound/music/unholy.ogg'
// 	converted_type = /area/rogue/outdoors/dungeon1

// /area/rogue/under/cave/inhumen/entrance // Only use these around traveltiles - Constantine
// 	name = "inhumen"

// /area/rogue/under/cave/inhumen/entrance/can_craft_here() //Made to prevent killboxes - Constantine
// 	return FALSE

// /area/rogue/under/cave/fishmandungeon //idk what the fish guys are called in lore
// 	name = "fishmandungeon"
// 	icon_state = "under"
// 	first_time_text = "INVASION STAGING AREA"
// 	droning_sound = 'sound/music/area/dungeon.ogg'
// 	droning_sound_dusk = null
// 	droning_sound_night = null
// 	converted_type = /area/rogue/outdoors/dungeon1
// 	ceiling_protected = TRUE

// //////
// /////
// ////     TOWN AREAS
// ////
// ///
// //



// /area/rogue/indoors/town
// 	name = "indoors"
// 	icon_state = "town"
// 	droning_sound = 'sound/music/area/towngen.ogg'
// 	droning_sound_dusk = 'sound/music/area/septimus.ogg'
// 	droning_sound_night = 'sound/music/area/sleeping.ogg'
// 	converted_type = /area/rogue/outdoors/exposed/town
// 	town_area = TRUE
// 	deathsight_message = "the city of Rotwood Vale and all its bustling souls"

// /area/rogue/outdoors/exposed/town
// 	icon_state = "town"
// 	droning_sound = 'sound/music/area/towngen.ogg'
// 	droning_sound_dusk = 'sound/music/area/septimus.ogg'
// 	droning_sound_night = 'sound/music/area/sleeping.ogg'

// /area/rogue/outdoors/exposed/town/keep
// 	name = "Keep"
// 	icon_state = "manor"
// 	droning_sound = 'sound/music/area/manorgarri.ogg'
// 	keep_area = TRUE
// 	town_area = TRUE

// /area/rogue/outdoors/exposed/town/keep/unbuildable
// 	name = "Keep unbuildable"

// /area/rogue/outdoors/exposed/town/keep/unbuildable/can_craft_here()
// 	return FALSE

// /area/rogue/indoors/town/manor
// 	name = "Manor"
// 	icon_state = "manor"
// 	droning_sound = list('sound/music/area/manor.ogg', 'sound/music/area/manor2.ogg')
// 	droning_sound_dusk = null
// 	droning_sound_night = null
// 	converted_type = /area/rogue/outdoors/exposed/manorgarri
// 	first_time_text = "THE KEEP OF ROTWOOD VALE"
// 	keep_area = TRUE

// /area/rogue/indoors/town/manor/rockhill
// 	first_time_text = "Rockhill Keep"

// /area/rogue/outdoors/exposed/manorgarri
// 	icon_state = "manorgarri"
// 	droning_sound = 'sound/music/area/manorgarri.ogg'
// 	droning_sound_dusk = null
// 	droning_sound_night = null
// 	keep_area = TRUE

// /area/rogue/indoors/town/magician
// 	name = "Wizard's Tower"
// 	icon_state = "magician"
// 	spookysounds = SPOOKY_MYSTICAL
// 	spookynight = SPOOKY_MYSTICAL
// 	droning_sound = 'sound/music/area/magiciantower.ogg'
// 	droning_sound_dusk = null
// 	droning_sound_night = null
// 	converted_type = /area/rogue/outdoors/exposed/magiciantower
// 	keep_area = TRUE

// /area/rogue/outdoors/exposed/magiciantower
// 	icon_state = "magiciantower"
// 	droning_sound = 'sound/music/area/magiciantower.ogg'
// 	droning_sound_dusk = null
// 	droning_sound_night = null
// 	keep_area = TRUE

// /area/rogue/indoors/town/shop
// 	name = "Shop"
// 	icon_state = "shop"
// 	droning_sound = 'sound/music/area/shop.ogg'
// 	droning_sound_dusk = null
// 	droning_sound_night = null
// 	converted_type = /area/rogue/outdoors/exposed/shop
// /area/rogue/outdoors/exposed/shop
// 	icon_state = "shop"
// 	droning_sound = 'sound/music/area/shop.ogg'

// /area/rogue/indoors/town/physician
// 	name = "Physician"
// 	icon_state = "physician"
// 	droning_sound = 'sound/music/area/academy.ogg'
// 	droning_sound_dusk = null
// 	droning_sound_night = null

// /area/rogue/indoors/town/Academy
// 	name = "Academy"
// 	icon_state = "academy"
// 	droning_sound = 'sound/music/area/academy.ogg'
// 	droning_sound_dusk = null
// 	droning_sound_night = null

// /area/rogue/indoors/town/bath
// 	name = "Baths"
// 	icon_state = "bath"
// 	droning_sound = 'sound/music/area/bath.ogg'
// 	droning_sound_dusk = null
// 	droning_sound_night = null
// 	converted_type = /area/rogue/outdoors/exposed/bath
// /area/rogue/outdoors/exposed/bath
// 	icon_state = "bath"
// 	droning_sound = 'sound/music/area/bath.ogg'

// /area/rogue/outdoors/exposed/bath/vault
// 	name = "Bathmaster vault"
// 	icon_state = "bathvault"
// 	ceiling_protected = TRUE

// /area/rogue/indoors/town/garrison
// 	name = "Garrison"
// 	icon_state = "garrison"
// 	droning_sound = 'sound/music/area/manorgarri.ogg'
// 	droning_sound_dusk = null
// 	droning_sound_night = null
// 	droning_sound_dusk = null
// 	droning_sound_night = null
// 	converted_type = /area/rogue/outdoors/exposed/manorgarri
// 	keep_area = TRUE

// /area/rogue/indoors/town/cell
// 	name = "dungeon cell"
// 	icon_state = "cell"
// 	spookysounds = SPOOKY_DUNGEON
// 	spookynight = SPOOKY_DUNGEON
// 	droning_sound = 'sound/music/area/catacombs.ogg'
// 	droning_sound_dusk = null
// 	droning_sound_night = null
// 	converted_type = /area/rogue/outdoors/exposed/manorgarri
// 	keep_area = TRUE
// 	cell_area = TRUE
// 	soundproof = TRUE

// /area/rogue/indoors/town/tavern
// 	name = "tavern"
// 	icon_state = "tavern"
// 	ambientsounds = AMB_INGEN
// 	ambientnight = AMB_INGEN
// 	droning_sound = 'sound/silence.ogg'
// 	droning_sound_dusk = null
// 	droning_sound_night = null
// 	converted_type = /area/rogue/outdoors/exposed/tavern
// 	tavern_area = TRUE
	
// /area/rogue/outdoors/exposed/tavern
// 	icon_state = "tavern"
// 	droning_sound = 'sound/silence.ogg'
// 	droning_sound_dusk = null
// 	droning_sound_night = null
// 	tavern_area = TRUE

// /area/rogue/indoors/town/church
// 	name = "church"
// 	icon_state = "church"
// 	droning_sound = 'sound/music/area/church.ogg'
// 	droning_sound_dusk = null
// 	droning_sound_night = null
// 	holy_area = TRUE
// 	droning_sound_dawn = 'sound/music/area/churchdawn.ogg'
// 	converted_type = /area/rogue/outdoors/exposed/church
// 	deathsight_message = "a hallowed place, sworn to the Ten"

// /area/rogue/outdoors/exposed/church
// 	icon_state = "church"
// 	droning_sound = 'sound/music/area/church.ogg'
// 	droning_sound_dusk = null
// 	droning_sound_night = null
// 	droning_sound_dawn = 'sound/music/area/churchdawn.ogg'
// 	deathsight_message = "a hallowed place, sworn to the Ten"

// /area/rogue/indoors/town/church/chapel
// 	icon_state = "chapel"
// 	first_time_text = "THE HOUSE OF THE TEN"

// /area/rogue/indoors/town/church/basement
// 	icon_state = "church"
// 	droning_sound = 'sound/music/area/catacombs.ogg'
// 	droning_sound_dusk = null
// 	droning_sound_night = null
// 	first_time_text = "THE CRYPT OF THE TEN"

// /area/rogue/indoors/town/warehouse
// 	name = "dock warehouse import"
// 	icon_state = "warehouse"


// /area/rogue/indoors/inq
// 	name = "The Inquisition"
// 	icon_state = "chapel"
// 	first_time_text = "THE OTAVAN INQUISITION"

// /area/rogue/indoors/inq/office
// 	name = "The Inquisitor's Office"
// 	icon_state = "chapel"

// /area/rogue/indoors/inq/basement
// 	name = "The Inquisition's Basement"
// 	icon_state = "chapel"
// 	ceiling_protected = TRUE
// 	droning_sound = 'sound/music/area/catacombs.ogg'
// 	droning_sound_dusk = null
// 	droning_sound_night = null

// /area/rogue/indoors/town/warehouse/can_craft_here()
// 	return FALSE

// /area/rogue/indoors/inq/import
// 	name = "foreign imports"
// 	icon_state = "warehouse"
// 	ceiling_protected = TRUE

// /area/rogue/indoors/inq/import/can_craft_here()
// 	return FALSE

// /area/rogue/indoors/town/vault
// 	name = "vault"
// 	icon_state = "vault"
// 	keep_area = TRUE
// /area/rogue/indoors/town/entrance
// 	first_time_text = "Roguetown"
// 	icon_state = "entrance"

// /area/rogue/indoors/town/dwarfin
// 	name = "The Guild of Craft"
// 	icon_state = "dwarfin"
// 	droning_sound = 'sound/music/area/dwarf.ogg'
// 	droning_sound_dusk = null
// 	droning_sound_night = null
// 	first_time_text = "VALE GUILD OF CRAFT"
// 	converted_type = /area/rogue/outdoors/exposed/dwarf

// /area/rogue/indoors/town/dwarfin/rockhill
// 	first_time_text = "Rockhill Guild of Crafts"

// /area/rogue/outdoors/exposed/dwarf
// 	icon_state = "dwarf"
// 	droning_sound = 'sound/music/area/dwarf.ogg'
// 	droning_sound_dusk = null
// 	droning_sound_night = null

// /area/rogue/indoors/town/grove
// 	name = "grove"
// 	icon_state = "druidgrove"
// 	droning_sound = 'sound/music/area/druid.ogg'
// 	droning_sound_dusk = null
// 	droning_sound_night = null
// 	droning_sound_dawn = 'sound/music/area/forest.ogg'
// 	converted_type = /area/rogue/indoors/shelter/woods
// 	deathsight_message = "A sacred place of dendor, beneath the tree of Aeons.."
// 	warden_area = TRUE
// 	town_area = FALSE

// ///// outside

// /area/rogue/outdoors/town
// 	name = "outdoors"
// 	icon_state = "town"
// 	soundenv = 16
// 	droning_sound = 'sound/music/area/townstreets.ogg'
// 	droning_sound_dusk = 'sound/music/area/septimus.ogg'
// 	droning_sound_night = 'sound/music/area/sleeping.ogg'
// 	converted_type = /area/rogue/indoors/shelter/town
// 	first_time_text = "THE CITY OF ROTWOOD VALE"
// 	town_area = TRUE

// /area/rogue/outdoors/town/rockhill
// 	name = "outdoors rockhill"
// 	first_time_text = "The Town of Rockhill"

// /area/rogue/indoors/shelter/town
// 	icon_state = "town"
// 	droning_sound = 'sound/music/area/townstreets.ogg'
// 	droning_sound_dusk = 'sound/music/area/septimus.ogg'
// 	droning_sound_night = 'sound/music/area/sleeping.ogg'


// /area/rogue/outdoors/town/sargoth
// 	name = "outdoors"
// 	icon_state = "sargoth"
// 	soundenv = 16
// 	droning_sound = 'sound/music/area/sargoth.ogg'
// 	droning_sound_dusk = null
// 	droning_sound_night = null
// 	converted_type = /area/rogue/indoors/shelter/town/sargoth
// 	first_time_text = "SARGOTH"
// /area/rogue/indoors/shelter/town/sargoth
// 	icon_state = "sargoth"
// 	droning_sound = 'sound/music/area/sargoth.ogg'
// 	droning_sound_dusk = null
// 	droning_sound_night = null
// 	first_time_text = "SARGOTH"

// /area/rogue/outdoors/town/roofs
// 	name = "roofs"
// 	icon_state = "roofs"
// 	ambientsounds = AMB_MOUNTAIN
// 	ambientnight = AMB_MOUNTAIN
// 	spookysounds = SPOOKY_GEN
// 	spookynight = SPOOKY_GEN
// 	droning_sound = 'sound/music/area/field.ogg'
// 	droning_sound_dusk = 'sound/music/area/septimus.ogg'
// 	droning_sound_night = 'sound/music/area/sleeping.ogg'
// 	soundenv = 17
// 	converted_type = /area/rogue/indoors/shelter/town/roofs
// 	first_time_text = null

// /area/rogue/outdoors/town/roofs/keep
// 	name = "Keep Rooftops"
// 	icon_state = "manor"
// 	keep_area = TRUE
// 	town_area = TRUE

// /area/rogue/indoors/shelter/town/roofs
// 	icon_state = "roofs"
// 	droning_sound = 'sound/music/area/field.ogg'
// 	droning_sound_dusk = 'sound/music/area/septimus.ogg'
// 	droning_sound_night = 'sound/music/area/sleeping.ogg'

// /area/rogue/outdoors/town/dwarf
// 	name = "dwarven quarter"
// 	icon_state = "dwarf"
// 	droning_sound = 'sound/music/area/dwarf.ogg'
// 	droning_sound_dusk = null
// 	droning_sound_night = null
// 	first_time_text = "The Dwarven Quarter"
// 	soundenv = 16
// 	converted_type = /area/rogue/indoors/shelter/town/dwarf

// /area/rogue/indoors/shelter/town/dwarf
// 	icon_state = "dwarf"
// 	droning_sound = 'sound/music/area/dwarf.ogg'
// 	droning_sound_dusk = null
// 	droning_sound_night = null

// /area/rogue/outdoors/town/grove
// 	icon_state = "druidgrove"
// 	color = "#b8b5c9"
// 	droning_sound = 'sound/music/area/druid.ogg'
// 	droning_sound_dawn = 'sound/music/area/forest.ogg'
// 	converted_type = /area/rogue/indoors/town/grove
// 	deathsight_message = "A sacred place of dendor, near the tree of Aeons.."
// 	droning_sound_dusk = null
// 	droning_sound_night = null
// 	warden_area = TRUE
// 	town_area = FALSE

// /// under


// /area/rogue/under/town
// 	name = "basement"
// 	icon_state = "town"
// 	droning_sound = 'sound/music/area/catacombs.ogg'
// 	droning_sound_dusk = null
// 	droning_sound_night = null
// 	converted_type = /area/rogue/outdoors/exposed/under/town
// /area/rogue/outdoors/exposed/under/town
// 	icon_state = "town"
// 	droning_sound = 'sound/music/area/catacombs.ogg'
// 	droning_sound_dusk = null
// 	droning_sound_night = null

// /area/rogue/under/town/sewer
// 	name = "sewer"
// 	icon_state = "sewer"
// 	ambientsounds = AMB_CAVEWATER
// 	ambientnight = AMB_CAVEWATER
// 	spookysounds = SPOOKY_RATS
// 	spookynight = SPOOKY_RATS
// 	droning_sound = 'sound/music/area/sewers.ogg'
// 	droning_sound_dusk = null
// 	droning_sound_night = null
// 	ambientrain = RAIN_SEWER
// 	soundenv = 21
// 	converted_type = /area/rogue/outdoors/exposed/under/sewer
// /area/rogue/outdoors/exposed/under/sewer
// 	icon_state = "sewer"
// 	droning_sound = 'sound/music/area/sewers.ogg'
// 	droning_sound_dusk = null
// 	droning_sound_night = null

// /area/rogue/under/town/caverogue
// 	name = "miningcave (roguetown)"
// 	icon_state = "caverogue"
// 	ambientsounds = AMB_GENCAVE
// 	ambientnight = AMB_GENCAVE
// 	spookysounds = SPOOKY_CAVE
// 	spookynight = SPOOKY_CAVE
// 	droning_sound = 'sound/music/area/caves.ogg'
// 	droning_sound_dusk = null
// 	droning_sound_night = null
// 	converted_type = /area/rogue/outdoors/exposed/under/caves
// /area/rogue/outdoors/exposed/under/caves
// 	icon_state = "caves"
// 	droning_sound = 'sound/music/area/caves.ogg'
// 	droning_sound_dusk = null
// 	droning_sound_night = null

// /area/rogue/under/town/basement
// 	name = "basement"
// 	icon_state = "basement"
// 	ambientsounds = AMB_BASEMENT
// 	ambientnight = AMB_BASEMENT
// 	spookysounds = SPOOKY_DUNGEON
// 	spookynight = SPOOKY_DUNGEON
// 	droning_sound = 'sound/music/area/catacombs.ogg'
// 	droning_sound_dusk = null
// 	droning_sound_night = null
// 	soundenv = 5
// 	town_area = TRUE
// 	converted_type = /area/rogue/outdoors/exposed/under/basement

// /area/rogue/under/town/basement/keep
// 	name = "keep basement"
// 	icon_state = "basement"
// 	keep_area = TRUE
// 	town_area = TRUE
// 	ceiling_protected = TRUE

// /area/rogue/under/town/basement/tavern
// 	name = "tavern basement"
// 	icon_state = "basement"
// 	tavern_area = TRUE
// 	town_area = TRUE
// 	ceiling_protected = TRUE

// /area/rogue/outdoors/exposed/under/basement
// 	icon_state = "basement"
// 	droning_sound = 'sound/music/area/catacombs.ogg'
// 	droning_sound_dusk = null
// 	droning_sound_night = null

// // underworld
// /area/rogue/underworld
// 	name = "underworld"
// 	icon_state = "underworld"
// 	droning_sound = 'sound/music/area/underworlddrone.ogg'
// 	droning_sound_dusk = null
// 	droning_sound_night = null
// 	first_time_text = "The Forest of Repentence"

// /area/rogue/underworld/dream
// 	name = "dream realm"
// 	icon_state = "dream"
// 	first_time_text = "Abyssal Dream"

// /area/rogue/underworld/adventurespawn
// 	name = "wayfarer's dream"
// 	icon_state = "dream"
// 	first_time_text = "A Wayfarer's Dream"
