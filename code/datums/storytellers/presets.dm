/// Code-defined gamemode presets. These replace the old storyteller gods. Players vote between them (grouped
/// into three pools - see GAMEMODE_POOL_* in __DEFINES/storytellers.dm) or admins fine-tune the roundstart
/// antag config directly.

/datum/storyteller/gamemode
	always_votable = TRUE

// ----------------------------------------------------------------------------------------------------------
// Extended - no hard antags and no soft antags
// ----------------------------------------------------------------------------------------------------------
/datum/storyteller/gamemode/extended
	name = "The Sleeping Wood"
	vote_desc = "Ratwood sleeps lightly: no hard or soft antagonists, and no Dreamwalker. Conflict must grow from those already beneath its boughs."
	desc = "A quiet Ratwood round with antagonist injection disabled; omens, raids, and the ordinary troubles of the realm remain."
	welcome_text = "The old trees stand still, and for once the roads beneath them carry no ill omen."
	color_theme = "#80ced8"
	preset_pool = GAMEMODE_POOL_EXTENDED
	block_hard = TRUE
	block_soft = TRUE
	allow_dreamwalker = FALSE
	preferred_gnoll_mode = GNOLL_SCALING_NONE
	gnoll_slot_cap = 0
	wretch_slot_cap = 0
	roundstart_prob = 0
	guarantees_roundstart_roleset = FALSE
	starting_point_multipliers = list(
		EVENT_TRACK_MUNDANE = 1,
		EVENT_TRACK_PERSONAL = 1,
		EVENT_TRACK_MODERATE = 1,
		EVENT_TRACK_INTERVENTION = 1,
		EVENT_TRACK_CHARACTER_INJECTION = 0,
		EVENT_TRACK_OMENS = 1,
		EVENT_TRACK_RAIDS = 1,
	)
	point_gains_multipliers = list(
		EVENT_TRACK_MUNDANE = 1,
		EVENT_TRACK_PERSONAL = 1,
		EVENT_TRACK_MODERATE = 1,
		EVENT_TRACK_INTERVENTION = 1,
		EVENT_TRACK_CHARACTER_INJECTION = 0,
		EVENT_TRACK_OMENS = 1,
		EVENT_TRACK_RAIDS = 1,
	)

// ----------------------------------------------------------------------------------------------------------
// Admin sandbox - NOT votable. Admins pick before the 120s mark to disable player vote and
// insert their own antags in.
// ----------------------------------------------------------------------------------------------------------
/datum/storyteller/gamemode/admin
	name = "Hands in the Canopy"
	vote_desc = "Ratwood's unseen hands arrange the threats of the round directly."
	desc = "Admin-controlled Ratwood sandbox. Staff configure soft scaling and individual hard-antagonist slots before voting locks."
	welcome_text = "Some unseen hand parts the branches, and fate takes the hidden path."
	color_theme = "#c8a13a"
	preset_pool = null
	always_votable = FALSE
	block_hard = FALSE
	block_soft = FALSE
	allow_dreamwalker = TRUE
	allow_bandits = TRUE
	guaranteed_hard = FALSE
	guarantees_roundstart_roleset = FALSE
	roundstart_prob = 0
	preferred_gnoll_mode = GNOLL_SCALING_DYNAMIC	// max 3
	gnoll_slot_cap = 3
	wretch_slot_cap = 12

	starting_point_multipliers = list(
		EVENT_TRACK_MUNDANE = 1,
		EVENT_TRACK_PERSONAL = 1,
		EVENT_TRACK_MODERATE = 1,
		EVENT_TRACK_INTERVENTION = 1,
		EVENT_TRACK_CHARACTER_INJECTION = 0,
		EVENT_TRACK_OMENS = 1,
		EVENT_TRACK_RAIDS = 1,
	)
	point_gains_multipliers = list(
		EVENT_TRACK_MUNDANE = 1,
		EVENT_TRACK_PERSONAL = 1,
		EVENT_TRACK_MODERATE = 1,
		EVENT_TRACK_INTERVENTION = 1,
		EVENT_TRACK_CHARACTER_INJECTION = 0,
		EVENT_TRACK_OMENS = 1,
		EVENT_TRACK_RAIDS = 1,
	)

// ----------------------------------------------------------------------------------------------------------
// Atleast one main antag will be selected
// ----------------------------------------------------------------------------------------------------------
/datum/storyteller/gamemode/guaranteed_antag
	name = "High Intensity: Black Boughs"
	vote_desc = "APEX THREAT: guarantees exactly one major roundstart threat, chosen between a Lich, a Vampire Lord, OR a Werewolf pack. Wretches stay low; Gnolls cap at 4 and supporting Bandits may appear, capped at 4."
	desc = "Focused on one major threat: a Lich, Vampire Lord, or pack of up to 5 Werewolves. Wretches and Gnolls cap at 4; optional supporting Bandits cap at 4."
	welcome_text = "The black boughs groan. A deathless will stirs below, and an ancient thirst wakes beneath the moon."
	color_theme = "#a43c3c"
	preset_pool = GAMEMODE_POOL_GUARANTEED
	guaranteed_hard = TRUE
	guarantees_roundstart_roleset = TRUE
	roundstart_prob = 100
	block_hard = FALSE
	block_soft = FALSE
	allow_dreamwalker = TRUE
	preferred_gnoll_mode = GNOLL_SCALING_FLAT	// Ratwood preset cap: 4
	gnoll_slot_cap = 4
	wretch_slot_cap = 4
	forced_roundstart_antags = list()
	guaranteed_roundstart_antags = list(
		/datum/round_event_control/antagonist/solo/lich,
		/datum/round_event_control/antagonist/solo/vampires,
		/datum/round_event_control/antagonist/solo/werewolf,
	)

/datum/storyteller/gamemode/guaranteed_antag/low_wretch
	name = "Medium Intensity: Blood on the Bark"
	vote_desc = "OUTLAW PRESSURE: no major hard antagonists. Wretches cap at 9, Bandits at 6, Gnolls at 4, and a Dreamwalker may appear."
	desc = "No Lich, Vampire Lord, Werewolf, or Masquerade. Wretches cap at 9; Bandits at 6; Gnolls at 4; Dreamwalker enabled."
	welcome_text = "Fresh cuts score the old bark; something hungry has already found the road."
	forced_roundstart_antags = list()
	guaranteed_roundstart_antags = list()
	color_theme = "#7a1f1f"
	hard_mult = 2
	guaranteed_hard = FALSE
	guarantees_roundstart_roleset = FALSE
	roundstart_prob = 50
	block_hard = TRUE
	block_soft = FALSE
	allow_dreamwalker = TRUE
	allow_bandits = TRUE
	preferred_gnoll_mode = GNOLL_SCALING_FLAT	// max 2
	gnoll_slot_cap = 4
	wretch_slot_cap = 9

// ----------------------------------------------------------------------------------------------------------
// Just wretches/gnolls and other soft antagonists
// ----------------------------------------------------------------------------------------------------------
/datum/storyteller/gamemode/no_antag	// DEFAULT
	name = "Standard Intensity: Crooked Roads"
	vote_desc = "Ratwood's usual danger: no hard antagonists, with Wretches up to 6, Gnolls up to 2, Assassins, and possibly a Dreamwalker."
	desc = "The standard Ratwood experience. No hard antagonists; Wretches cap at 6 and Gnolls at 2."
	welcome_text = "Daelight reaches the crooked roads, but the wood keeps secrets beneath every root."
	color_theme = "#2b8c87"
	preset_pool = GAMEMODE_POOL_NOANTAG
	block_hard = TRUE
	block_soft = FALSE
	allow_dreamwalker = TRUE
	preferred_gnoll_mode = GNOLL_SCALING_FLAT	// max 2
	gnoll_slot_cap = 2
	wretch_slot_cap = 6
	roundstart_prob = 50
	guarantees_roundstart_roleset = FALSE

/datum/storyteller/gamemode/no_antag/small_wretch
	name = "Low Intensity: Quiet Underbrush"
	vote_desc = "A gentler Ratwood: no hard antagonists or Dreamwalker, with only a small fixed complement of soft antagonists."
	desc = "Low-pressure Ratwood. No hard antagonists; Wretches remain at 5 and Gnolls at 1."
	welcome_text = "Only small things move in the underbrush, and the old wood keeps its deeper hungers asleep."
	color_theme = "#1f6b67"
	allow_dreamwalker = FALSE
	preferred_gnoll_mode = GNOLL_SCALING_SINGLE	// max 1
	gnoll_slot_cap = 1
	wretch_slot_cap = 5
	roundstart_prob = 0

	starting_point_multipliers = list(
		EVENT_TRACK_MUNDANE = 1,
		EVENT_TRACK_PERSONAL = 1,
		EVENT_TRACK_MODERATE = 1,
		EVENT_TRACK_INTERVENTION = 1,
		EVENT_TRACK_CHARACTER_INJECTION = 0,
		EVENT_TRACK_OMENS = 1,
		EVENT_TRACK_RAIDS = 1,
	)
	point_gains_multipliers = list(
		EVENT_TRACK_MUNDANE = 1,
		EVENT_TRACK_PERSONAL = 1,
		EVENT_TRACK_MODERATE = 1,
		EVENT_TRACK_INTERVENTION = 1,
		EVENT_TRACK_CHARACTER_INJECTION = 0,
		EVENT_TRACK_OMENS = 1,
		EVENT_TRACK_RAIDS = 1,
	)
