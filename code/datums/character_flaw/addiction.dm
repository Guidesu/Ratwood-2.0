/mob/proc/sate_addiction()
	return

/mob/living/carbon/human/sate_addiction(addiction_type)
	var/datum/charflaw/addiction/A

	// If a specific addiction type is requested, only sate that one.
	if(addiction_type)
		if(length(vices))
			for(var/datum/charflaw/vice in vices)
				if(istype(vice, addiction_type))
					A = vice
					break
		if(!A && istype(charflaw, addiction_type))
			A = charflaw
	else
		// Otherwise, try to find an addiction vice (prefer an unsated one).
		if(length(vices))
			for(var/datum/charflaw/vice in vices)
				if(!istype(vice, /datum/charflaw/addiction))
					continue
				var/datum/charflaw/addiction/candidate = vice
				if(!A)
					A = candidate
					continue
				if(A.sated && !candidate.sated)
					A = candidate
		if(!A && istype(charflaw, /datum/charflaw/addiction))
			A = charflaw

	if(!A)
		return

	if(!A.sated)
		to_chat(src, span_blue(A.sated_text))
	A.sated = TRUE
	A.time = initial(A.time) //reset roundstart sate offset to standard
	A.next_sate = world.time + A.time
	remove_stress(A.stress_event)  // Remove vice-specific stress event
	if(A.debuff)
		remove_status_effect(A.debuff)
	
	// Voyeur witnessing - sate nearby voyeurs who witness this addiction being sated
	// Prevent infinite loops by not sating voyeurs when a voyeur is already being sated
	if(!istype(A, /datum/charflaw/addiction/voyeur))
		for(var/mob/living/carbon/human/H in hearers(7, src))
			if(H == src)
				continue
			if(H.has_flaw(/datum/charflaw/addiction/voyeur))
				H.sate_addiction(/datum/charflaw/addiction/voyeur)

/datum/charflaw/addiction
	needs_life_tick = TRUE
	var/next_sate = 0
	var/sated = TRUE
	var/time = 5 MINUTES
//	var/debuff = /datum/status_effect/debuff/addiction
	var/debuff //so heroin junkies can have big problems
	var/needsate_text
	var/sated_text = "That's much better..."
	var/unsate_time
	var/stress_event = /datum/stressevent/vice  // Specific stress event type for this vice


/datum/charflaw/addiction/New()
	..()
	time = rand(6 MINUTES, 30 MINUTES)
	next_sate = world.time + time

// Clean up addiction effects when vice is removed
/datum/charflaw/addiction/on_removal(mob/user)
	if(!ishuman(user))
		return
	var/mob/living/carbon/human/H = user
	// Remove stress event
	if(stress_event)
		H.remove_stress(stress_event)
	// Remove debuff
	if(debuff)
		H.remove_status_effect(debuff)

/datum/charflaw/addiction/flaw_on_life(mob/user)
	if(!ishuman(user))
		return
	if(user.mind?.antag_datums)
		for(var/datum/antagonist/D in user.mind?.antag_datums)
			if(istype(D, /datum/antagonist/vampire/lord) || istype(D, /datum/antagonist/werewolf) || istype(D, /datum/antagonist/skeleton) || istype(D, /datum/antagonist/zombie) || istype(D, /datum/antagonist/lich))
				return
	var/mob/living/carbon/human/H = user
	var/oldsated = sated
	if(oldsated)
		if(next_sate)
			if(world.time > next_sate)
				sated = FALSE
	if(sated != oldsated)
		unsate_time = world.time
		if(needsate_text)
			to_chat(user, span_boldwarning("[needsate_text]"))
	if(!sated)
		H.add_stress(stress_event)  // Use vice-specific stress event
		if(debuff)
			H.apply_status_effect(debuff)



/datum/status_effect/debuff/addiction
	id = "addiction"
	alert_type = /atom/movable/screen/alert/status_effect/debuff/addiction
	effectedstats = list(STATKEY_WIL = -1,STATKEY_LCK = -1)
	duration = 100


/atom/movable/screen/alert/status_effect/debuff/addiction
	name = "Addiction"
	desc = ""
	icon_state = "debuff"


/// ALCOHOLIC

/datum/charflaw/addiction/alcoholic
	name = "Alcoholic"
	desc = "I need to drink alcohol regularly. If I go too long without a drink, I'll become increasingly stressed and suffer withdrawal symptoms (reduced WIL and LCK)."
	time = 40 MINUTES
	needsate_text = "Time for a drink."
	stress_event = /datum/stressevent/vice/alcoholic
	debuff = /datum/status_effect/debuff/addiction/alcoholic

/datum/status_effect/debuff/addiction/alcoholic
	id = "addiction_alcoholic"
	alert_type = /atom/movable/screen/alert/status_effect/debuff/addiction/alcoholic
	effectedstats = list(STATKEY_INT = -1, STATKEY_WIL = -1)

/atom/movable/screen/alert/status_effect/debuff/addiction/alcoholic
	name = "Alcohol Withdrawal"
	desc = "I've started to feel hungover. The best way to chase a hangover is another drink."
	icon_state = "alcoholic"


/// KLEPTOMANIAC

/datum/charflaw/addiction/kleptomaniac
	name = "Thief-borne"
	desc = "I must steal something regularly to satisfy my compulsion. Going too long without theft causes mounting stress and anxiety (reduced WIL and LCK)."
	time = 30 MINUTES
	needsate_text = "I need to STEAL something! I'll die if I don't!"
	stress_event = /datum/stressevent/vice/kleptomaniac
	debuff = /datum/status_effect/debuff/addiction/kleptomaniac

/datum/status_effect/debuff/addiction/kleptomaniac
	id = "addiction_kleptomaniac"
	alert_type = /atom/movable/screen/alert/status_effect/debuff/addiction/kleptomaniac
	effectedstats = list(STATKEY_LCK = -2)

/atom/movable/screen/alert/status_effect/debuff/addiction/kleptomaniac
	name = "Kleptomaniac"
	desc = "I haven't picked any pockets recently. My fingers are itching to steal."
	icon_state = "kleptomaniac"


/// JUNKIE

/datum/charflaw/addiction/junkie
	name = "Junkie"
	desc = "I need hard drugs like ozium, moon dust, or lux regularly. Without my fix, I'll suffer increasing stress and withdrawal symptoms (reduced WIL and LCK)."
	time = 40 MINUTES
	needsate_text = "Time to get really high."
	stress_event = /datum/stressevent/vice/junkie
	debuff = /datum/status_effect/debuff/addiction/junkie

/datum/status_effect/debuff/addiction/junkie
	id = "addiction_junkie"
	alert_type = /atom/movable/screen/alert/status_effect/debuff/addiction/junkie
	effectedstats = list(STATKEY_STR = -1, STATKEY_CON = -1)

/atom/movable/screen/alert/status_effect/debuff/addiction/junkie
	name = "Drug Withdrawal"
	desc = "It's been too long since my last bump. I need a hit of something strong."
	icon_state = "junkie"

/// Smoker

/datum/charflaw/addiction/smoker
	name = "Smoker"
	desc = "I need to smoke pipe weed, zig, or westleach regularly. Going without causes mounting stress and irritability (reduced WIL and LCK)."
	time = 40 MINUTES
	needsate_text = "Time for a flavorful smoke."
	stress_event = /datum/stressevent/vice/smoker
	debuff = /datum/status_effect/debuff/addiction/smoker

/datum/status_effect/debuff/addiction/smoker
	id = "addiction_smoker"
	alert_type = /atom/movable/screen/alert/status_effect/debuff/addiction/smoker
	effectedstats = list(STATKEY_STR = -1, STATKEY_CON = -1)

/atom/movable/screen/alert/status_effect/debuff/addiction/smoker
	name = "Blacklung"
	desc = "I need a smoke. Gotta take the edge off."
	icon_state = "smoker"

/// GOD-FEARING

/datum/charflaw/addiction/godfearing
	name = "Devout Follower"
	desc = "I must pray regularly to maintain my spiritual well-being. Neglecting prayer causes stress and spiritual malaise (reduced WIL and LCK)."
	time = 40 MINUTES
	needsate_text = "Time to pray to my Patron."
	stress_event = /datum/stressevent/vice/godfearing
	debuff = /datum/status_effect/debuff/addiction/godfearing

/datum/status_effect/debuff/addiction/godfearing
	id = "addiction_godfearing"
	alert_type = /atom/movable/screen/alert/status_effect/debuff/addiction/godfearing
	effectedstats = list(STATKEY_WIL = -2)

/atom/movable/screen/alert/status_effect/debuff/addiction/godfearing
	name = "Godfearing"
	desc = "It's been too long since my last prayer. My patron is going to turn their gaze away from me."
	icon_state = "godfearing"

/// CAFFIEND

/datum/charflaw/addiction/caffiend
	name = "Caffiend"
	desc = "I can't start my day without a cup of tea or coffee."
	time = 40 MINUTES
	needsate_text = "I need a hot brew."
	stress_event = /datum/stressevent/vice/caffiend

/// SADIST

/datum/charflaw/addiction/sadist
	name = "Sadist"
	desc = "I need to inflict pain on others regularly to feel satisfied. Going too long without hurting someone causes mounting stress and irritability (reduced WIL and LCK)."
	time = 40 MINUTES
	needsate_text = "I need to hear someone whimper."
	stress_event = /datum/stressevent/vice/sadist
	debuff = /datum/status_effect/debuff/addiction/sadist

/datum/status_effect/debuff/addiction/sadist
	id = "addiction_sadist"
	alert_type = /atom/movable/screen/alert/status_effect/debuff/addiction/sadist
	effectedstats = list(STATKEY_WIL = -1, STATKEY_LCK = -1)

/atom/movable/screen/alert/status_effect/debuff/addiction/sadist
	name = "Sadist"
	desc = "I need to hear someone whimper. Only the cries of another will make me feel better."
	icon_state = "sadist"

/// MASOCHIST

/datum/charflaw/addiction/masochist
	name = "Masochist"
	desc = "I need to experience pain regularly to feel alive. Without it, I become increasingly stressed and anxious (reduced WIL and LCK)."
	time = 40 MINUTES
	needsate_text = "I need someone to HURT me."
	stress_event = /datum/stressevent/vice/masochist
	debuff = /datum/status_effect/debuff/addiction/masochist

/datum/status_effect/debuff/addiction/masochist
	id = "addiction_masochist"
	alert_type = /atom/movable/screen/alert/status_effect/debuff/addiction/masochist
	effectedstats = list(STATKEY_CON = -1, STATKEY_WIL = -1)

/atom/movable/screen/alert/status_effect/debuff/addiction/masochist
	name = "Masochist"
	desc = "I deserve to suffer. No, I NEED to suffer."
	icon_state = "masochist"

/// CLAMOROUS

/datum/charflaw/addiction/clamorous
	name = "Clamorous"
	desc = "I thrive on noise and chaos. Complete silence makes me anxious. Combat sounds and lively conversation keep me sated."
	time = 40 MINUTES
	needsate_text = "I need to hear some noise, some action..."
	sated_text = "The sounds invigorate me."
	stress_event = /datum/stressevent/vice/clamorous

/// THRILLSEEKER

/datum/charflaw/addiction/thrillseeker
	name = "Thrillseeker"
	desc = "I crave the rush of combat and danger. Extended fights or near-death experiences satisfy my need for excitement."
	time = 40 MINUTES
	needsate_text = "I need to feel the thrill of battle..."
	sated_text = "The rush of combat invigorates me!"
	stress_event = /datum/stressevent/vice/thrillseeker
	needs_life_tick = TRUE
	var/combat_start_time = 0
	var/in_combat = FALSE

/datum/charflaw/addiction/thrillseeker/flaw_on_life(mob/living/carbon/human/user)
	// Check if combat has lasted long enough (70 seconds)
	if(in_combat && (world.time - combat_start_time >= 70 SECONDS))
		user.sate_addiction(/datum/charflaw/addiction/thrillseeker)
		in_combat = FALSE
		combat_start_time = 0
	
	// Check if we're in crit (near death experience)
	if(user.InCritical() && !sated)
		user.sate_addiction(/datum/charflaw/addiction/thrillseeker)
		in_combat = FALSE
		combat_start_time = 0

/// PARANOID

/datum/charflaw/addiction/paranoid
	name = "Paranoid"
	desc = "I trust only my own kind. Being around different factions makes me deeply anxious, but seeing my own people calms me."
	time = 40 MINUTES
	needsate_text = "I need to see one of my own..."
	sated_text = "Seeing one of my own calms my nerves."
	stress_event = /datum/stressevent/vice/paranoid

/datum/charflaw/addiction/paranoid/proc/check_faction(mob/living/carbon/human/checker, mob/living/carbon/human/target)
	if(!checker?.client?.prefs?.paranoid_chosen_faction || !target?.mind?.assigned_role)
		return FALSE
	
	var/datum/job/target_job = SSjob.GetJob(target.mind.assigned_role)
	if(!target_job)
		return FALSE
	
	return (target_job.department_flag & checker.client.prefs.paranoid_chosen_faction)

/// VOYEUR

/datum/charflaw/addiction/voyeur
	name = "Voyeur"
	desc = "I find satisfaction in witnessing others indulge their vices. Seeing someone else achieve satisfaction vicariously sates my own needs."
	time = 40 MINUTES
	needsate_text = "I need to see someone indulge..."
	sated_text = "Watching them satisfy their needs satisfies mine..."
	stress_event = /datum/stressevent/vice/voyeur

/// NYMPHOMANIAC

/datum/charflaw/addiction/lovefiend
	name = "Nymphomaniac"
	desc = "I must make love!"
	time = 90 MINUTES
	needsate_text = "I'm feeling randy."
	stress_event = /datum/stressevent/vice/nympho
	debuff = /datum/status_effect/debuff/addiction/nympho

/datum/status_effect/debuff/addiction/nympho
	id = "addiction_nympho"
	alert_type = /atom/movable/screen/alert/status_effect/debuff/addiction/nympho
	effectedstats = list(STATKEY_WIL = -1, STATKEY_LCK = -1)

/atom/movable/screen/alert/status_effect/debuff/addiction/nympho
	name = "Nymphomania"
	desc = "I must make love. My loins burn with unsated desire."
	icon_state = "nymphomaniac"

/datum/charflaw/addiction/baothamarked
	name = "Baothan Marked"
	desc = "I've been branded by a Baothan mark."
	time = 45 MINUTES
	needsate_text = "My brand burns painfully."
	sated_text = "The brand's glow lessens, relief washing over me..."
	stress_event = /datum/stressevent/vice/baothamarked
	debuff = /datum/status_effect/debuff/addiction/baothamarked

/datum/status_effect/debuff/addiction/baothamarked
	id = "addiction_baothamark"
	alert_type = /atom/movable/screen/alert/status_effect/debuff/addiction/baothamarked
	effectedstats = list(STATKEY_CON = -1, STATKEY_WIL = -1)

/atom/movable/screen/alert/status_effect/debuff/addiction/baothamarked
	name = "Baothan Mania"
	desc = "That accursed rune. It burns brightly across my flesh, searing my loins with a painful desire for release."
	icon_state = "nymphomaniac"
