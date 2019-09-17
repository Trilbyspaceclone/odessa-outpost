var/list/clients = list()							//list of all clients
var/list/admins = list()							//list of all clients whom are admins
var/list/directory = list()							//list of all ckeys with associated client

//Since it didn't really belong in any other category, I'm putting this here
//This is for procs to replace all the goddamn 'in world's that are chilling around the code

GLOBAL_LIST_EMPTY(player_list)				//List of all mobs **with clients attached**. Excludes /mob/new_player
GLOBAL_LIST_EMPTY(human_mob_list)				//List of all human mobs and sub-types, including clientless
GLOBAL_LIST_EMPTY(silicon_mob_list)			//List of all silicon mobs, including clientless
GLOBAL_LIST_EMPTY(living_mob_list)			//List of all alive mobs, including clientless. Excludes /mob/new_player
GLOBAL_LIST_EMPTY(dead_mob_list)				//List of all dead mobs, including clientless. Excludes /mob/new_player
var/global/list/current_antags = list()
var/global/list/current_factions = list()
var/global/list/antag_team_objectives = list()		//List of shared sets of objectives for antag teams
var/global/list/antag_team_members = list()			//List of the people who are in antag teams

GLOBAL_LIST_EMPTY(factions_list)			//List of active factions.
GLOBAL_LIST_EMPTY(faxable_factions_list)	//Factions with faxes.
GLOBAL_LIST_EMPTY(player_factions_list)		//Factions with players in them. Admin factions can have players added.
GLOBAL_LIST_EMPTY(admin_factions_list)		//Factions with administrative response. All faxes to an admin faction pass through admins first, even with a primary fax.

var/global/list/cable_list = list()					//Index for all cables, so that powernets don't have to look through the entire world all the time
var/global/list/chemical_reactions_list				//list of all /datum/chemical_reaction datums. Used during chemical reactions
GLOBAL_LIST_EMPTY(chemical_reactions_list_by_result)					//list of all /datum/chemical_reaction datums. But this one indexed by chemical result instead of reagents
var/global/list/chemical_reagents_list				//list of all /datum/reagent datums indexed by reagent id. Used by chemistry stuff
var/global/list/landmarks_list = list()				//list of all landmarks created
var/global/list/shuttle_landmarks_list = list()		//list of all /obj/effect/shuttle_landmark.
var/global/list/surgery_steps = list()				//list of all surgery steps  |BS12
var/global/list/mechas_list = list()				//list of all mechs. Used by hostile mobs target tracking.



var/global/list/hearing_objects = list()			//list of all objects, that can hear mob say

//Jobs and economy
var/global/list/joblist = list()					//list of all jobstypes, minus borg and AI
var/global/list/all_departments = list()			//List of all department datums
var/global/list/department_IDs = list(DEPARTMENT_COMMAND, DEPARTMENT_MEDICAL, DEPARTMENT_ENGINEERING,
 DEPARTMENT_SCIENCE, DEPARTMENT_SECURITY, DEPARTMENT_GUILD, DEPARTMENT_CHURCH, DEPARTMENT_CIVILIAN)
var/global/list/global_corporations = list()


var/global/list/HUDdatums = list()

#define all_genders_define_list list(MALE, FEMALE, PLURAL, NEUTER)

var/global/list/turfs = list()						//list of all turfs

var/list/mannequins_

//Languages/species/whitelist.
var/global/list/all_species[0]
var/global/list/all_languages[0]
var/global/list/language_keys[0]					// Table of say codes for all languages
var/global/list/whitelisted_species = list("Human") // Species that require a whitelist check.
var/global/list/playable_species = list("Human")    // A list of ALL playable species, whitelisted, latejoin or otherwise.

// Posters
var/global/list/poster_designs = list()

// Uplinks
var/list/obj/item/device/uplink/world_uplinks = list()

// Loot stash datums
GLOBAL_LIST_EMPTY(stash_categories) //An associative list in the format category_type = weight

GLOBAL_LIST_EMPTY(all_stash_datums)
//An associative list of lists in the format:
/*
	category_type = list(
	datum = weight)
*/


//NeoTheology
GLOBAL_LIST_EMPTY(all_rituals)//List of all rituals
GLOBAL_LIST_EMPTY(global_ritual_cooldowns) // internal lists. Use ritual's cooldown_category

//Preferences stuff
	//Body Sprites
GLOBAL_LIST_EMPTY(all_species_form_list)
GLOBAL_LIST_EMPTY(playable_species_form_list)
GLOBAL_LIST_EMPTY(selectable_species_form_list)
	//Hairstyles
GLOBAL_LIST_EMPTY(hair_styles_list)        //stores /datum/sprite_accessory/hair indexed by name
GLOBAL_LIST_EMPTY(facial_hair_styles_list) //stores /datum/sprite_accessory/facial_hair indexed by name
	//Body Adornments
GLOBAL_LIST_EMPTY(ears_styles_list)
GLOBAL_LIST_EMPTY(tail_styles_list)
GLOBAL_LIST_EMPTY(wings_styles_list)
GLOBAL_LIST_EMPTY(body_marking_list)

GLOBAL_DATUM_INIT(underwear, /datum/category_collection/underwear, new())

var/global/list/backbaglist = list("Nothing", "Backpack", "Satchel", "Satchel Alt")
var/global/list/exclude_jobs = list(/datum/job/ai,/datum/job/cyborg)

var/global/list/organ_structure = list(
	chest = list(name= "Chest", children=list()),
	groin = list(name= "Groin",     parent=BP_CHEST, children=list()),
	head  = list(name= "Head",      parent=BP_CHEST, children=list()),
	r_arm = list(name= "Right arm", parent=BP_CHEST, children=list()),
	l_arm = list(name= "Left arm",  parent=BP_CHEST, children=list()),
	r_leg = list(name= "Right leg", parent=BP_GROIN, children=list()),
	l_leg = list(name= "Left leg",  parent=BP_GROIN, children=list()),
	)

var/global/list/organ_tag_to_name = list(
	head  = "Head" ,r_arm = "Right arm",
	chest = "Body" ,r_leg = "Right Leg",
	eyes  = "Eyes" ,l_arm = "Left arm",
	groin = "Groin",l_leg = "Left Leg",
	torso = "Body" ,heart = "Heart",
	lungs = "Lungs",liver = "Liver",
	back  = "Back"
	)


// Visual nets
var/list/datum/visualnet/visual_nets = list()
var/datum/visualnet/camera/cameranet = new()

var/global/list/syndicate_access = list(access_maint_tunnels, access_syndicate, access_external_airlocks)

// Strings which corraspond to bodypart covering flags, useful for outputting what something covers.
var/global/list/string_part_flags = list(
	"head" = HEAD,
	"face" = FACE,
	"eyes" = EYES,
	"upper body" = UPPER_TORSO,
	"lower body" = LOWER_TORSO,
	"legs" = LEGS,
	"arms" = ARMS
)

// Strings which corraspond to slot flags, useful for outputting what slot something is.
var/global/list/string_slot_flags = list(
	"back" = SLOT_BACK,
	"face" = SLOT_MASK,
	"waist" = SLOT_BELT,
	"ID slot" = SLOT_ID,
	"ears" = SLOT_EARS,
	"eyes" = SLOT_EYES,
	"hands" = SLOT_GLOVES,
	"head" = SLOT_HEAD,
	"feet" = SLOT_FEET,
	"exo slot" = SLOT_OCLOTHING,
	"body" = SLOT_ICLOTHING,
	"uniform" = SLOT_ACCESSORY_BUFFER,
	"holster" = SLOT_HOLSTER
)

//A list of slots where an item doesn't count as "worn" if it's in one of them
var/global/list/unworn_slots = list(slot_l_hand,slot_r_hand, slot_l_store, slot_r_store,slot_robot_equip_1,slot_robot_equip_2,slot_robot_equip_3)


//////////////////////////
/////Initial Building/////
//////////////////////////

/proc/makeDatumRefLists()

	var/list/paths

	//Hair - Initialise all /datum/sprite_accessory/hair into an list indexed by hair-style name
	paths = typesof(/datum/sprite_accessory/hair) - /datum/sprite_accessory/hair
	for(var/path in paths)
		var/datum/sprite_accessory/hair/H = new path()
		GLOB.hair_styles_list[H.name] = H

	//Facial Hair - Initialise all /datum/sprite_accessory/facial_hair into an list indexed by facialhair-style name
	paths = typesof(/datum/sprite_accessory/facial_hair) - /datum/sprite_accessory/facial_hair
	for(var/path in paths)
		var/datum/sprite_accessory/facial_hair/H = new path()
		GLOB.facial_hair_styles_list[H.name] = H

	// Ears
	paths = typesof(/datum/sprite_accessory/ears) - /datum/sprite_accessory/ears
	for(var/path in paths)
		var/datum/sprite_accessory/ears/E = new path()
		GLOB.ears_styles_list[E.name] = E

	// Tails
	paths = typesof(/datum/sprite_accessory/tail) - /datum/sprite_accessory/tail - /datum/sprite_accessory/tail/taur
	for(var/path in paths)
		var/datum/sprite_accessory/tail/T = new path()
		GLOB.tail_styles_list[T.name] = T

	// Wings
	paths = typesof(/datum/sprite_accessory/wings) - /datum/sprite_accessory/wings
	for(var/path in paths)
		var/datum/sprite_accessory/wings/W = new path()
		GLOB.wings_styles_list[W.name] = W

	//Markings
	paths = typesof(/datum/sprite_accessory/marking) - /datum/sprite_accessory/marking
	for(var/path in paths)
		var/datum/sprite_accessory/marking/M = new path()
		GLOB.body_marking_list[M.name] = M


	//Surgery Steps - Initialize all /datum/surgery_step into a list
	paths = typesof(/datum/surgery_step)-/datum/surgery_step
	for(var/T in paths)
		var/datum/surgery_step/S = new T
		surgery_steps += S
	sort_surgeries()

	//List of job department datums
	paths = subtypesof(/datum/department)
	for(var/T in paths)
		var/datum/department/D = new T
		all_departments[D.id] = D

	//List of job datums
	paths = typesof(/datum/job)-/datum/job
	paths -= exclude_jobs
	for(var/T in paths)
		var/datum/job/J = new T
		joblist[J.title] = J

	//List of factions
	paths = typesof(/datum/faction)-/datum/faction
	for(var/T in paths)
		var/datum/faction/F = new T()
		GLOB.factions_list[F.name] = F
		if(F.faxable)
			GLOB.faxable_factions_list[F.name] = F
		if(F.admin)
			GLOB.admin_factions_list[F.name] = F
		//Player factions don't get loaded here since they have to be done at roundstart.

	//Stashes
	paths = subtypesof(/datum/stash)
	for(var/T in paths)
		var/datum/stash/L = new T
		//First, make a sublist in the main list if we haven't already
		//And make a sublist in the main list if we haven't already
		if (!GLOB.all_stash_datums[L.base_type])
			GLOB.all_stash_datums[L.base_type] = list()

		if (L.type == L.base_type)
			//This is a base category. Add it to the categories list with a weighting
			GLOB.stash_categories[L.base_type] = L.weight

		else
			//This is a specific stash datum, add it to the appropriate sublist
			GLOB.all_stash_datums[L.base_type][L] = L.weight


	//Languages and species.
	paths = typesof(/datum/language)-/datum/language
	for(var/T in paths)
		var/datum/language/L = new T
		all_languages[L.name] = L

	for (var/language_name in all_languages)
		var/datum/language/L = all_languages[language_name]
		if(!(L.flags & NONGLOBAL))
			language_keys[lowertext(L.key)] = L

	//var/rkey = 0
	paths = typesof(/datum/species)-/datum/species
	for(var/T in paths)
		//rkey++
		var/datum/species/S = new T
		//S.race_key = rkey //Used in mob icon caching. Not anymore!
		all_species[S.name] = S

		if(!(S.spawn_flags & IS_RESTRICTED))
			playable_species += S.name
		if(S.spawn_flags & IS_WHITELISTED)
			whitelisted_species += S.name

	//Forms
	var/fkey = 0
	paths = typesof(/datum/species_form)-/datum/species_form
	for(var/path in paths)
		fkey++
		var/datum/species_form/F = new path
		F.form_key = fkey //Used in mob icon caching. The one a segment above is obsoleted by this.
		GLOB.all_species_form_list[F.name] = F
		if(F.playable)
			GLOB.playable_species_form_list[F.name] = F
			if(!F.variantof || F.variantof == F.name)
				GLOB.selectable_species_form_list[F.name] = F

	//Form Variants System
	for(var/formname in GLOB.playable_species_form_list)
		var/datum/species_form/F = GLOB.all_species_form_list[formname]
		if(F.variantof && (F.variantof != F.name))
			var/datum/species_form/P = GLOB.all_species_form_list[F.variantof]
			if(P)
				LAZYINITLIST(P.variants)
				if(!P.variants.len)
					P.variants[P.name] = P
				P.variants[F.name] = F

	//Posters
	paths = typesof(/datum/poster) - /datum/poster - /datum/poster/wanted
	for(var/T in paths)
		var/datum/poster/P = new T
		poster_designs += P

	//Corporations
	paths = typesof(/datum/corporation) - /datum/corporation
	for(var/T in paths)
		var/datum/corporation/C = new T
		global.global_corporations[C.name] = C

	paths = typesof(/datum/hud) - /datum/hud
	for(var/T in paths)
		var/datum/hud/C = new T
		global.HUDdatums[C.name] = C

	//Rituals
	paths = typesof(/datum/ritual)
	for(var/T in paths)
		var/datum/ritual/R = new T

		//Rituals which are just categories for subclasses will have a null phrase
		if (R.phrase)
			GLOB.all_rituals[R.name] = R


	return 1


var/global/list/admin_permissions = list(
	"fun" = 0x1,
	"server" = 0x2,
	"debug" = 0x4,
	"permissions" = 0x8,
	"mentor" = 0x10,
	"moderator" = 0x20,
	"admin" = 0x40,
	"host" = 0x80
	)

/proc/get_mannequin(var/ckey)
	if(!mannequins_)
		mannequins_ = new()
	. = mannequins_[ckey]
	if(!.)
		. = new/mob/living/carbon/human/dummy/mannequin()
		mannequins_[ckey] = .

var/global/list/severity_to_string = list("[EVENT_LEVEL_MUNDANE]" = "Mundane", "[EVENT_LEVEL_MODERATE]" = "Moderate", "[EVENT_LEVEL_MAJOR]" = "Major", "[EVENT_LEVEL_ROLESET]" = "Roleset","[EVENT_LEVEL_ECONOMY]" = "Economy")



//*** params cache
/*
	Ported from bay12, this seems to be used to store and retrieve 2D vectors as strings, as well as
	decoding them into a number
*/
var/global/list/paramslist_cache = list()

#define cached_key_number_decode(key_number_data) cached_params_decode(key_number_data, /proc/key_number_decode)
#define cached_number_list_decode(number_list_data) cached_params_decode(number_list_data, /proc/number_list_decode)

/proc/cached_params_decode(var/params_data, var/decode_proc)
	. = paramslist_cache[params_data]
	if(!.)
		. = call(decode_proc)(params_data)
		paramslist_cache[params_data] = .

/proc/key_number_decode(var/key_number_data)
	var/list/L = params2list(key_number_data)
	for(var/key in L)
		L[key] = text2num(L[key])
	return L

/proc/number_list_decode(var/number_list_data)
	var/list/L = params2list(number_list_data)
	for(var/i in 1 to L.len)
		L[i] = text2num(L[i])
	return L