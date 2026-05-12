/**
 * Group Identity System
 *
 * A clean, modular system for giving species the old system.
 * (packs, clans, tribes, lineages, etc.) that appear on examine.
 *
 * Usage:
 *   - Set group_identity_type on a species datum to one of the subtypes below.
 *   - Set species_group on the mob/preferences to a string from that datum's entries list.
 *   - Examine will display it automatically.
 *
 * To add a new species group:
 *   1. Add a new /datum/group_identity subtype here with label and entries.
 *   2. Set group_identity_type on the species datum.
 *   Done. No other files need touching.
 */

/datum/group_identity
	/// The wording used on examine and in the preferences UI. E.g. "Pack", "Clan", "Tribe".
	var/label = "Group"
	/// Flat list of valid group name strings.
	var/list/entries = list()
	/// Optional: if set, players can choose which label word to use for their group.
	/// E.g. list("Pack", "Tribe", "Pride", "Clan") — player picks one, it replaces label on examine.
	/// Leave null to use the fixed label above.
	var/list/selectable_labels = null

// ──────────────────────────────────────────────────────────────────────────────
// HUMAN TYPES
// ──────────────────────────────────────────────────────────────────────────────

/datum/group_identity/humen
	label = "Ancestry"
	entries = list(
		"Giza",
		"Shalvistine",
		"Lalvestine",
		"Free Roamer",
		"North Zybantium, Chorodiaki",
		"West Zybantium, Vrdaqnan",
	)

/datum/group_identity/halfelf
	label = "Identity"
	entries = list(
		"Grenzelhoft",
		"Hammerhold",
		"Avar",
		"Otava",
		"Etrusca",
		"Naledi",
		"Kazengun",
		"Silvenmere",
		"Thornwood",
		"Underdark",
	)

// ──────────────────────────────────────────────────────────────────────────────
// ELF TYPES
// ──────────────────────────────────────────────────────────────────────────────

/datum/group_identity/elf_wood
	label = "Tribal Identity"
	entries = list(
		"Silvenmere",
		"Thornwood",
		"Ashgrove",
		"Mossfall",
		"Dawnbloom",
		"Embervale",
		"Coldroot",
		"Stoneleaf",
		"Briarsong",
		"Mistglade",
	)

/datum/group_identity/elf_dark
	label = "Origin City-State"
	entries = list(
		"Commorah",
		"Gloomhaven",
		"Darkpila",
		"Sshanntynlan",
		"Llurth Dreir",
		"Tafravma",
		"Yuethindrynn",
		"Koredynn",
		"Aiseedrynn",
		"Grenduskra",
		"Hunsek",
	)

// ──────────────────────────────────────────────────────────────────────────────
// DWARF TYPES
// ──────────────────────────────────────────────────────────────────────────────

/datum/group_identity/dwarf_mountain
	label = "Dwarf Fortress"
	entries = list(
		"Irondeep",
		"Stonehammer",
		"Coppervault",
		"Goldvein",
		"Ashpeak",
		"Frosthold",
		"Emberkeep",
		"Gravelton",
		"Rimrock",
		"Blastforge",
	)

// ──────────────────────────────────────────────────────────────────────────────
// ORC / HALF-ORC
// ──────────────────────────────────────────────────────────────────────────────

/datum/group_identity/orc
	label = "Clan"
	entries = list(
		"Shellcrest",
		"Bloodaxe",
		"Splitjaw",
		"Blackhammer",
		"Skullseeker",
		"Crescent Fang",
		"Murkwalker",
		"Shatterhorn",
		"Spirit Crusher",
	)

/datum/group_identity/halforc
	label = "Clan"
	entries = list(
		"Shellcrest",
		"Bloodaxe",
		"Splitjaw",
		"Blackhammer",
		"Skullseeker",
		"Crescent Fang",
		"Murkwalker",
		"Shatterhorn",
		"Spirit Crusher",
		"Underdweller",
	)

// ──────────────────────────────────────────────────────────────────────────────
// AASIMAR
// ──────────────────────────────────────────────────────────────────────────────

/datum/group_identity/aasimar
	label = "Craft"
	entries = list(
		"Cultor",
		"Archon",
		"Spiritus",
		"Planetar",
		"Deva",
		"Solar",
		"Empyrea",
		"Gaeia",
		"Celestial",
		"Olympia",
		"Necral",
		"Abyssal",
	)

// ──────────────────────────────────────────────────────────────────────────────
// TIEFLING / TIEBERIAN
// ──────────────────────────────────────────────────────────────────────────────

/datum/group_identity/tieberian
	label = "Progenitor"
	entries = list(
		"Jehoel",
		"Urvix",
		"Sarvyra",
		"Vheslyn",
		"Arlenneth",
		"Nessyss",
		"Helixia",
		"Nymsea",
		"Vodyanev",
		"Calvus",
		"Voibion",
		"Chyerno",
		"Drema",
		"Chir",
		"Vesyl",
		"Krosec",
		"Asza",
		"Krizzsha",
		"Tosiz",
		"Velothel",
		"Ashol",
	)

// ──────────────────────────────────────────────────────────────────────────────
// DULLAHAN
// ──────────────────────────────────────────────────────────────────────────────

/datum/group_identity/dullahan
	label = "Catalyst"
	entries = list(
		"Grenzelhoft",
		"Hammerhold",
		"Ebon",
		"Kazengun",
		"Vheslyn",
		"Arlenneth",
		"Nessyss",
		"Helixia",
		"Nymsea",
		"Commorah",
		"Gloomhaven",
		"Darkpila",
		"Sshanntynlan",
		"Llurth Dreir",
		"Tafravma",
		"Yuethindrynn",
	)

// ──────────────────────────────────────────────────────────────────────────────
// LUPIAN
// ──────────────────────────────────────────────────────────────────────────────

/datum/group_identity/lupian
	label = "Pack"
	entries = list(
		"Vakran",
		"Lanarain",
		"Frostfell",
		"Varghelm",
		"Dawnbreak",
		"Bloodmoon",
		"Felsaad",
		"Hizmut",
		"Langqan",
		"a tangled lineage",
		"disputed",
		"bastardized",
		"Czwarteki",
	)

// ──────────────────────────────────────────────────────────────────────────────
// ARACHNID
// ──────────────────────────────────────────────────────────────────────────────

/datum/group_identity/arachnid
	label = "Brood"
	entries = list(
		"Ghost",
		"Grenzel Woods",
		"Dandelion Creek",
		"Roseveil",
		"Azuregrove",
		"Arborshome",
		"Almondvalle",
		"Walnut Woods",
		"Timberborn",
		"Lotus Coast",
		"Etruscan Swamps",
		"Shalvine Forests",
		"Lalvestine Thickets",
		"Ebon Coverts",
	)

// ──────────────────────────────────────────────────────────────────────────────
// LAMIA
// ──────────────────────────────────────────────────────────────────────────────

/datum/group_identity/lamia
	label = "Brood"
	entries = list(
		"Ghost",
		"Grenzel Woods",
		"Dandelion Creek",
		"Roseveil",
		"Azuregrove",
		"Arborshome",
		"Almondvalle",
		"Walnut Woods",
		"Timberborn",
		"Lotus Coast",
		"Etruscan Swamps",
		"Shalvine Forests",
		"Lalvestine Thickets",
		"Ebon Coverts",
	)

// ──────────────────────────────────────────────────────────────────────────────
// HARPY
// ──────────────────────────────────────────────────────────────────────────────

/datum/group_identity/harpy
	label = "Ancestry"
	entries = list(
		"Grenzelhoft",
		"Hammerhold",
		"Avar",
		"Otava",
		"Etrusca",
		"Gronn",
		"Giza",
		"Shalvistine",
		"Lalvestine",
		"Kazengun",
		"Naledi",
	)

// ──────────────────────────────────────────────────────────────────────────────
// MODULAR FURRY SPECIES
// ──────────────────────────────────────────────────────────────────────────────

/datum/group_identity/dracon
	label = "Bloodline"
	entries = list(
		"Emberveil",
		"Frostbound",
		"Shadowscale",
		"Stormcrest",
		"Ironscale",
		"Voidborn",
		"Ashblood",
		"Tidecrest",
		"Cinderkin",
		"Stoneback",
	)

/datum/group_identity/tabaxi
	label = "Heritage"
	entries = list(
		"Moonpaw",
		"Sunwhisker",
		"Shadowstep",
		"Goldmane",
		"Stoneclaw",
		"Nightfang",
		"Emberpelt",
		"Silvermane",
		"Swiftclaw",
		"Ashpelt",
	)

/datum/group_identity/lizardfolk
	label = "Kin"
	entries = list(
		"Marshkin",
		"Sandscale",
		"Swampkin",
		"Stonescale",
		"Riverkin",
		"Ashkin",
		"Forestkin",
		"Brinekin",
		"Mirekin",
		"Dustkin",
	)

/datum/group_identity/kobold
	label = "Tribe"
	entries = list(
		"Bonediggers",
		"Coppersnout",
		"Dustcrawlers",
		"Ironmaw",
		"Mudshards",
		"Runescratch",
		"Scalebacks",
		"Stonebite",
		"Thornclaw",
		"Webbers",
	)

/datum/group_identity/moth
	label = "Circle"
	entries = list(
		"Circle of Dusk",
		"Circle of Embers",
		"Circle of Frost",
		"Circle of Silence",
		"Circle of Starweave",
		"Circle of Moonveil",
		"Circle of Ash",
		"Circle of Dawn",
		"Circle of Veilmist",
		"Circle of Thornspire",
	)

/datum/group_identity/vulpkanin
	label = "Tribe"
	entries = list(
		"Ashpelt",
		"Coppertail",
		"Dustrunners",
		"Emberfur",
		"Frostmane",
		"Goldwhisker",
		"Ironpaw",
		"Moonshadow",
		"Silvertip",
		"Thornback",
	)

/datum/group_identity/anthromorph
	label = "Lineage"
	entries = list(
		"Ashborne",
		"Dustwalker",
		"Emberpelt",
		"Frostclaw",
		"Goldmane",
		"Ironback",
		"Marshborn",
		"Nightpelt",
		"Stonekin",
		"Thornpelt",
	)

/datum/group_identity/anthromorphsmall
	label = "Lineage"
	entries = list(
		"Ashsnout",
		"Burrowers",
		"Dustscurry",
		"Emberclaw",
		"Furrowback",
		"Gnawers",
		"Hollowkin",
		"Ironpaw",
		"Mudbelly",
		"Swiftpaw",
	)

/datum/group_identity/demihuman
	label = "Ancestry"
	entries = list(
		"Fairkith",
		"Goldkith",
		"Olivekith",
		"Amberkith",
		"Bronzekith",
		"Ashkith",
		"Duskkith",
		"Shadowkith",
	)
