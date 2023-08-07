class_name Upgrade
extends Resource



enum Type {
	MECHANICAL, # S2 M
	LIMIT_BREAK,
	DONT_TAKE_CANDY_FROM_BABIES,
	SPLISHY_SPLASHY,
	MILK,
	FALCON_PAWNCH,
	SPEED_SHOPPER,
	AUTOSMITHY,
	GATORADE,
	KAIO_KEN,
	AUTOSENSU,
	APPLE_JUICE,
	DANCE_OF_THE_FIRE_GOD,
	SUDDEN_COMMISSION,
	PEPPERMINT_MOCHA,
	RASENGAN,
	MUDSLIDE,
	THE_GREAT_JOURNEY,
	BEAVER,
	MODS_ENABLED,
	COVENANT_DANCE,
	OVERTIME,
	BONE_MEAL,
	SILLY,
	SPEED_DOODS,
	EREBOR,
	CHILD_ENERGY,
	PLATE,
	MASTER,
	STRAWBERRY_BANANA_SMOOTHIE,
	AVATAR_STATE,
	AXELOT,
	GREEN_TEA,
	HAMON,
	AUTOSHIT,
	FRENCH_VANILLA,
	METAL_CAP,
	SMASHY_CRASHY,
	WATER,
	STAR_ROD,
	A_BABY_ROLEUM,
	POOFY_WIZARD_BOY,
	BENEFIT,
	AUTOAQUATICIDE,
	GO_ON_THEN_LEAD_US,
	THE_WITCH_OF_LOREDELITH,
	TOLKIEN,
	BEEKEEPING,
	ELBOW_STRAPS,
	AUTO_PERSIST,
	KETO,
	NOW_THATS_WHAT_IM_TALKIN_ABOUT,
	SCOOPY_DOOPY,
	THE_ATHORE_COMENTS_AL_TOTOL_LIES,
	ITS_SPREADIN_ON_ME,
	WHAT_IN_COUSIN_FUCKIN_TARNATION,
	MASTER_IRON_WORKER,
	JOINTSHACK,
	DUST,
	CAPITAL_PUNISHMENT,
	AROUSAL,
	AUTOFLOOF,
	ELECTRONIC_CIRCUITS,
	AUTOBADDECISIONMAKER,
	CONDUCT,
	PILLAR_OF_AUTUMN,
	WHAT_KIND_OF_RESOURCE_IS_TUMORS,
	DEVOUR,
	IS_IT_SUPPOSED_TO_BE_STICK_DUDES,
	I_DISAGREE,
	HOME_RUN_BAT,
	BLAM_THIS_PIECE_OF_CRAP,
	DOT_DOT_DOT,
	ONE_PUNCH,
	SICK_OF_THE_SUN,
	AXMAN13,
	CTHAEH,
	RED_NECROMANCY,
	UPGRADE_DESCRIPTION,
	GRIMOIRE,
	
	CANOPY, # S2 N
	APPRENTICE_IRON_WORKER,
	DOUBLE_BARRELS,
	RAIN_DANCE,
	LIGHTHOUSE,
	ROGUE_BLACKSMITH,
	TRIPLE_BARRELS,
	BREAK_THE_DAM,
	THIS_MIGHT_PAY_OFF_SOMEDAY,
	DIRT_COLLECTION_REWARDS_PROGRAM,
	EQUINE,
	UNPREDICTABLE_WEATHER,
	DECISIVE_STRIKES,
	SOFT_AND_SMOOTH,
	FLIPPY_FLOPPIES,
	WOODTHIRSTY,
	SEEING_BROWN,
	WOODIAC_CHOPPER,
	CARLIN,
	HARDWOOD_YOURSELF,
	STEEL_YOURSELF,
	PLASMA_BOMBARDMENT,
	PATREON_ARTIST,
	MILLERY,
	QUAMPS,
	TWO_FIVE_FIVE_TWO,
	GIMP,
	SAGAN,
	HENRY_CAVILL,
	LEMBAS_WATER,
	BIGGER_TREES_I_GUESS,
	JOURNEYMAN_IRON_WORKER,
	CUTTING_CORNERS,
	QUORMPS,
	KILTY_SBARK,
	HOLE_GEOMETRY,
	CIORAN,
	WOOD_LORD,
	EXPERT_IRON_WORKER,
	THEYVE_ALWAYS_BEEN_FASTER,
	WHERES_THE_BOY_STRING,
	UTTER_MOLESTER_CHAMP,
	CANCERS_REAL_COOL,
	SPOOKY,
	SQUEEORMP,
	SANDAL_FLANDALS,
	GLITTERDELVE,
	VIRILE,
	FACTORY_SQUIRTS,
	LONGBOTTOM_LEAF,
	INDEPENDENCE,
	NIKEY_WIKEYS,
	ERECTWOOD,
	STEELY_DAN,
	MGALEKGOLO,
	PULLEY,
	LE_GUIN,
	FLEEORMP,
	POTENT,
	LIGHT_AS_A_FEATHER,
	BUSY_BEE,
	DINDER_MUFFLIN,
	ULTRA_SHITSTINCT,
	AND_THIS_IS_TO_GO_EVEN_FURTHER_BEYOND,
	POWER_BARRELS,
	A_BEE_WITH_TINY_DAGGERS,
	HARDWOOD_YO_MAMA,
	STEEL_YO_MAMA,
	MAGNETIC_ACCELERATOR,
	SPOOLY,
	TORIYAMA,
	BURDENED,
	SQUEEOMP,
	BARELY_WOOD_BY_NOW,
	FINGERS_OF_ONDEN,
	O_SALVATORI,
	LOW_RISES,
	ILL_SHOW_YOU_HARDWOOD,
	STEEL_LORD,
	FINISH_THE_FIGHT,
	MICROSOFT_PAINT,
	JOHN_PETER_BAIN_TOTALBISCUIT,
	
	
	
	AUTOSHOVELER, # S1 M
	SOCCER_DUDE,
	AW,
	ENTHUSIASM,
	CON_FRICKIN_CRETE,
	HOW_IS_THIS_AN_RPG,
	ITS_GROWIN_ON_ME,
	AUTOSTONER,
	OREOREUHBOREALICE,
	YOU_LITTLE_HARD_WORKER_YOU,
	COMPULSORY_JUICE,
	BIG_TOUGH_BOY,
	STAY_QUENCHED,
	OH_BABY_A_TRIPLE,
	AUTOPOLICE,
	PIPPENPADDLE_OPPSOCOPOLIS,
	I_DRINK_YOUR_MILKSHAKE,
	ORE_LORD,
	MOIST,
	THE_THIRD,
	WE_WERE_SO_CLOSE,
	UPGRADE_NAME,
	WTF_IS_THAT_MUSK,
	CANCERS_COOL,
	I_RUN,
	COAL_DUDE,
	CANKERITE,
	SENTIENT_DERRICK,
	SLAPAPOW,
	SIDIUS_IRON,
	MOUND,
	FOOD_TRUCKS,
	OPPAI_GUY,
	MALEVOLENT,
	SLUGGER,
	THIS_GAME_IS_SO_ESEY,
	WAIT_THATS_NOT_FAIR,
	PROCEDURE,
	ROUTINE,
	
	
	GRINDER, # S1 N
	LIGHTER_SHOVEL,
	TEXAS,
	RYE,
	GRANDER,
	SAALNDT,
	SALT,
	SAND,
	GRANDMA,
	MIXER,
	FLANK,
	RIB,
	GRANDPA,
	WATT,
	SWIRLER,
	GEARED_OILS,
	CHEEKS,
	GROUNDER,
	MAXER,
	THYME,
	PEPPER,
	ANCHOVE_COVE,
	GARLIC,
	MUD,
	SLOP,
	SLIMER,
	STICKYTAR,
	INJECT,
	RED_GOOPY_BOY,
}

class Effect:
	
	enum Type {
		HASTE,
		OUTPUT_AND_INPUT,
		SPECIFIC_INPUT,
		INPUT,
		CRIT,
		FUEL,
		FUEL_COST,
		ITS_GROWIN_ON_ME,
	}
	
	var TYPE_KEYS := Type.keys()
	
	var type: int
	var key: String
	var text: String
	
	var applied := false
	
	var effect: Attribute
	var in_hand: Big
	
	var apply_methods: Array
	var remove_methods: Array
	
	var effected_input: int
	
	var effect2: Attribute
	var in_hand2: Big
	
	
	
	func _init(_type: int, details: Dictionary) -> void:
		type = _type
		key = TYPE_KEYS[type]
		
		effect = Attribute.new(details["effect value"], false)
		if details["effected_input"] >= 0:
			effected_input = details["effected_input"]
		if type == Type.ITS_GROWIN_ON_ME:
			effect2 = Attribute.new(details["effect value"], false)
		
		set_base_text()
	
	
	
	func set_base_text() -> void:
		match type:
			Type.SPECIFIC_INPUT:
				text = wa.get_currency_name(effected_input) + " Input [b]x"
			Type.FUEL:
				text = "Max Fuel x[b]"
			Type.OUTPUT_AND_INPUT:
				text = "Output and Input x[b]"
			_:
				text = key.replace("_", " ").capitalize() + " x[b]"
	
	
	# - Actions
	
	func add_effected_lored(lored: LORED) -> void:
		match type:
			Type.SPECIFIC_INPUT:
				for att in lored.get_attributes_by_currency(effected_input):
					apply_methods.append(att.increase_multiplied)
					remove_methods.append(att.decrease_multiplied)
			Type.HASTE:
				apply_methods.append(lored.haste.increase_multiplied)
				remove_methods.append(lored.haste.decrease_multiplied)
			Type.OUTPUT_AND_INPUT:
				apply_methods.append(lored.output.increase_multiplied)
				apply_methods.append(lored.input.increase_multiplied)
				remove_methods.append(lored.output.decrease_multiplied)
				remove_methods.append(lored.input.decrease_multiplied)
			Type.INPUT:
				apply_methods.append(lored.input.increase_multiplied)
				remove_methods.append(lored.input.decrease_multiplied)
			Type.CRIT:
				apply_methods.append(lored.crit.increase_multiplied)
				remove_methods.append(lored.crit.decrease_multiplied)
			Type.FUEL:
				apply_methods.append(lored.fuel.increase_multiplied)
				remove_methods.append(lored.fuel.decrease_multiplied)
			Type.FUEL_COST:
				apply_methods.append(lored.fuel_cost.increase_multiplied)
				remove_methods.append(lored.fuel_cost.decrease_multiplied)
	
	
	func apply() -> void:
		if not applied:
			effect.add_notify_change_method(refresh)
			if type == Type.ITS_GROWIN_ON_ME:
				effect2.add_notify_change_method(refresh)
	
	
	func remove() -> void:
		if applied:
			effect.remove_notify_method(refresh)
			remove_effects()
			if type == Type.ITS_GROWIN_ON_ME:
				effect2.remove_notify_method(refresh)
	
	
	func refresh() -> void:
		remove_effects()
		apply_effects()
	
	
	func apply_effects() -> void:
		if not applied:
			applied = true
			in_hand = Big.new(effect.get_value())
			match type:
				Type.ITS_GROWIN_ON_ME:
					in_hand2 = Big.new(effect2.get_value())
					var iron := lv.get_lored(LORED.Type.IRON)
					var copper := lv.get_lored(LORED.Type.COPPER)
					iron.output.increase_multiplied(in_hand)
					iron.input.increase_multiplied(in_hand)
					copper.output.increase_multiplied(in_hand2)
					copper.input.increase_multiplied(in_hand2)
				_:
					for method in apply_methods:
						method.call(in_hand)
	
	
	func remove_effects() -> void:
		if applied:
			applied = false
			match type:
				Type.ITS_GROWIN_ON_ME:
					var iron := lv.get_lored(LORED.Type.IRON)
					var copper := lv.get_lored(LORED.Type.COPPER)
					iron.output.decrease_multiplied(in_hand)
					iron.input.decrease_multiplied(in_hand)
					copper.output.decrease_multiplied(in_hand2)
					copper.input.decrease_multiplied(in_hand2)
				_:
					for method in remove_methods:
						method.call(in_hand)
	
	
	# - Get
	
	func get_text() -> String:
		return text + effect.get_text()





signal just_purchased
signal purchased_changed

var TYPE_KEYS := Type.keys()
var type: int
var stage: int
var upgrade_tab: int

var times_purchased := 0
var purchase_limit := 1
var key: String
var name: String
var description: String
var has_description: bool
var effect_text: String

var icon: Texture
var color: Color
var loreds: Array
var effected_loreds_text: String

var special: bool
var effects_applied := false
var purchased := false
var will_apply_effect := false

var effect: Effect
#

var cost: Cost



func _init(_type: int) -> void:
	type = _type
	key = TYPE_KEYS[type]
	if type >= Type.AUTOSHOVELER:
		stage = 1
		special = type <= Type.ROUTINE
	elif type >= Type.MECHANICAL:
		stage = 2
		special = type <= Type.GRIMOIRE
	else: #s4
		stage = 3
		special = false #s3
	
	match stage:
		1:
			if special:
				upgrade_tab = up.UpgradeMenu.Type.MALIGNANT
			else:
				upgrade_tab = up.UpgradeMenu.Type.NORMAL
		2:
			if special:
				upgrade_tab = up.UpgradeMenu.Type.RADIATIVE
			else:
				upgrade_tab = up.UpgradeMenu.Type.EXTRA_NORMAL
		3:
			if special:
				upgrade_tab = up.UpgradeMenu.Type.SPIRIT
			else:
				upgrade_tab = up.UpgradeMenu.Type.RUNED_DIAL
		4:
			if special:
				upgrade_tab = up.UpgradeMenu.Type.S4N
			else:
				upgrade_tab = up.UpgradeMenu.Type.S4M
	
	if type != Type.ROUTINE:
		up.add_upgrade_total(upgrade_tab)
	
	if not has_method("init_" + key):
		return
	call("init_" + key)
	
	effected_loreds_text = get_effected_loreds_text()
	
	if icon == null:
		if loreds.size() < 10:
			var highest = 0
			var i = 0
			var ok = 0
			for x in loreds:
				if x.type > highest:
					highest = x.type
					ok = i
				i += 1
			icon = loreds[ok].icon
			color = loreds[ok].color
	
	has_description = description != ""



func init_GRINDER() -> void:
	name = "GRINDER"
	set_effect(Effect.Type.HASTE, 1.25)
	add_effected_lored(LORED.Type.STONE)
	cost = Cost.new({
		Currency.Type.STONE: Attribute.new(90, false),
	})


func init_LIGHTER_SHOVEL() -> void:
	name = "Lighter Shovel"
	set_effect(Effect.Type.HASTE, 1.2)
	add_effected_lored(LORED.Type.COAL)
	cost = Cost.new({
		Currency.Type.COPPER: Attribute.new(155, false),
	})


func init_TEXAS() -> void:
	name = "TEXAS"
	set_effect(Effect.Type.HASTE, 1.25)
	add_effected_lored(LORED.Type.IRON)
	cost = Cost.new({
		Currency.Type.GROWTH: Attribute.new(30, false),
		Currency.Type.COPPER: Attribute.new(400, false),
	})


func init_RYE() -> void:
	name = "RYE"
	set_effect(Effect.Type.HASTE, 1.25)
	add_effected_lored(LORED.Type.COPPER)
	cost = Cost.new({
		Currency.Type.GROWTH: Attribute.new(3, false),
		Currency.Type.IRON: Attribute.new(100, false),
	})


func init_GRANDER() -> void:
	name = "GRANDER"
	set_effect(Effect.Type.HASTE, 1.3)
	add_effected_lored(LORED.Type.STONE)
	cost = Cost.new({
		Currency.Type.COAL: Attribute.new(400, false),
	})


func init_SAALNDT() -> void:
	name = "SAALNDT"
	set_effect(Effect.Type.HASTE, 1.5)
	add_effected_lored(LORED.Type.IRON_ORE)
	add_effected_lored(LORED.Type.COPPER_ORE)
	cost = Cost.new({
		Currency.Type.IRON_ORE: Attribute.new(1500, false),
		Currency.Type.COPPER_ORE: Attribute.new(1500, false),
	})


func init_SALT() -> void:
	name = "SALT"
	set_effect(Effect.Type.OUTPUT_AND_INPUT, 1.25)
	add_effected_lored(LORED.Type.IRON)
	cost = Cost.new({
		Currency.Type.GROWTH: Attribute.new(150, false),
	})


func init_SAND() -> void:
	name = "SAND"
	set_effect(Effect.Type.HASTE, 1.25)
	add_effected_lored(LORED.Type.COPPER)
	cost = Cost.new({
		Currency.Type.GROWTH: Attribute.new(200, false),
	})


func init_GRANDMA() -> void:
	name = "Grandma"
	set_effect(Effect.Type.HASTE, 1.3)
	add_effected_lored(LORED.Type.STONE)
	cost = Cost.new({
		Currency.Type.IRON: Attribute.new(400, false),
		Currency.Type.COPPER: Attribute.new(400, false),
		Currency.Type.CONCRETE: Attribute.new(20, false),
	})


func init_MIXER() -> void:
	name = "MIXER"
	set_effect(Effect.Type.HASTE, 1.5)
	add_effected_lored(LORED.Type.CONCRETE)
	cost = Cost.new({
		Currency.Type.CONCRETE: Attribute.new(11, false),
	})


func init_FLANK() -> void:
	name = "FLANK"
	set_effect(Effect.Type.HASTE, 1.4)
	add_effected_lored(LORED.Type.IRON)
	cost = Cost.new({
		Currency.Type.MALIGNANCY: Attribute.new(125, false),
	})


func init_RIB() -> void:
	name = "RIB"
	set_effect(Effect.Type.OUTPUT_AND_INPUT, 1.4)
	add_effected_lored(LORED.Type.COPPER)
	cost = Cost.new({
		Currency.Type.MALIGNANCY: Attribute.new(125, false),
	})


func init_GRANDPA() -> void:
	name = "Grandpa"
	set_effect(Effect.Type.OUTPUT_AND_INPUT, 1.35)
	add_effected_lored(LORED.Type.STONE)
	cost = Cost.new({
		Currency.Type.IRON: Attribute.new(2500, false),
		Currency.Type.COPPER: Attribute.new(2500, false),
	})


func init_WATT() -> void:
	name = "Watt?"
	set_effect(Effect.Type.OUTPUT_AND_INPUT, 1.45)
	add_effected_lored(LORED.Type.JOULES)
	cost = Cost.new({
		Currency.Type.IRON: Attribute.new(3500, false),
		Currency.Type.COPPER: Attribute.new(3500, false),
	})


func init_SWIRLER() -> void:
	name = "SWIRLER"
	set_effect(Effect.Type.HASTE, 1.5)
	add_effected_lored(LORED.Type.CONCRETE)
	cost = Cost.new({
		Currency.Type.COAL: Attribute.new(9500, false),
		Currency.Type.STONE: Attribute.new(6000, false),
	})


func init_GEARED_OILS() -> void:
	name = "Geared Oils"
	set_effect(Effect.Type.OUTPUT_AND_INPUT, 2.0)
	add_effected_lored(LORED.Type.OIL)
	cost = Cost.new({
		Currency.Type.IRON: Attribute.new("6e6", false),
	})


func init_CHEEKS() -> void:
	name = "Cheeks"
	set_effect(Effect.Type.OUTPUT_AND_INPUT, 1.5)
	add_effected_lored(LORED.Type.OIL)
	cost = Cost.new({
		Currency.Type.STONE: Attribute.new(200000, false),
		Currency.Type.IRON: Attribute.new(120000, false),
		Currency.Type.COPPER: Attribute.new(40000, false),
		Currency.Type.COAL: Attribute.new(30000, false),
		Currency.Type.GROWTH: Attribute.new(5000, false),
		Currency.Type.CONCRETE: Attribute.new(1500, false),
		Currency.Type.MALIGNANCY: Attribute.new(15, false),
		Currency.Type.OIL: Attribute.new(1, false),
	})


func init_GROUNDER() -> void:
	name = "GROUNDER"
	set_effect(Effect.Type.HASTE, 1.35)
	add_effected_lored(LORED.Type.STONE)
	cost = Cost.new({
		Currency.Type.GROWTH: Attribute.new(100, false),
		Currency.Type.JOULES: Attribute.new(100, false),
	})


func init_MAXER() -> void:
	name = "MAXER"
	set_effect(Effect.Type.OUTPUT_AND_INPUT, 1.4)
	add_effected_lored(LORED.Type.CONCRETE)
	cost = Cost.new({
		Currency.Type.GROWTH: Attribute.new(400, false),
	})


func init_THYME() -> void:
	name = "THYME"
	set_effect(Effect.Type.OUTPUT_AND_INPUT, 1.75)
	add_effected_lored(LORED.Type.COPPER_ORE)
	add_effected_lored(LORED.Type.COPPER)
	cost = Cost.new({
		Currency.Type.IRON: Attribute.new("2e6", false),
		Currency.Type.MALIGNANCY: Attribute.new(35000, false),
	})


func init_PEPPER() -> void:
	name = "PEPPER"
	set_effect(Effect.Type.OUTPUT_AND_INPUT, 10)
	add_effected_lored(LORED.Type.IRON_ORE)
	cost = Cost.new({
		Currency.Type.COPPER: Attribute.new("25e9", false),
		Currency.Type.MALIGNANCY: Attribute.new("15e6", false),
	})


func init_ANCHOVE_COVE() -> void:
	name = "Anchove Cove"
	set_effect(Effect.Type.HASTE, 2)
	add_effected_lored(LORED.Type.IRON_ORE)
	add_effected_lored(LORED.Type.COPPER_ORE)
	cost = Cost.new({
		Currency.Type.IRON_ORE: Attribute.new(450000, false),
		Currency.Type.COPPER_ORE: Attribute.new(450000, false),
	})


func init_GARLIC() -> void:
	name = "GARLIC"
	set_effect(Effect.Type.OUTPUT_AND_INPUT, 10)
	add_effected_lored(LORED.Type.COPPER_ORE)
	cost = Cost.new({
		Currency.Type.IRON: Attribute.new("25e9", false),
		Currency.Type.MALIGNANCY: Attribute.new("15e6", false),
	})


func init_MUD() -> void:
	name = "MUD"
	set_effect(Effect.Type.OUTPUT_AND_INPUT, 1.75)
	add_effected_lored(LORED.Type.IRON_ORE)
	add_effected_lored(LORED.Type.IRON)
	cost = Cost.new({
		Currency.Type.COPPER: Attribute.new("2e6", false),
		Currency.Type.MALIGNANCY: Attribute.new(35000, false),
	})


func init_SLOP() -> void:
	name = "SLOP"
	set_effect(Effect.Type.HASTE, 1.95)
	add_effected_lored(LORED.Type.GROWTH)
	cost = Cost.new({
		Currency.Type.STONE: Attribute.new("1e6", false),
	})


func init_SLIMER() -> void:
	name = "SLIMER"
	set_effect(Effect.Type.HASTE, 1.5)
	add_effected_lored(LORED.Type.GROWTH)
	cost = Cost.new({
		Currency.Type.MALIGNANCY: Attribute.new(150, false),
	})


func init_STICKYTAR() -> void:
	name = "Sticktar"
	set_effect(Effect.Type.SPECIFIC_INPUT, 0.5, Currency.Type.TARBALLS)
	add_effected_lored(LORED.Type.MALIGNANCY)
	cost = Cost.new({
		Currency.Type.GROWTH: Attribute.new(1400, false),
		Currency.Type.OIL: Attribute.new(75, false),
	})


func init_INJECT() -> void:
	name = "INJECT"
	set_effect(Effect.Type.OUTPUT_AND_INPUT, 2)
	add_effected_lored(LORED.Type.TARBALLS)
	cost = Cost.new({
		Currency.Type.TUMORS: Attribute.new(100, false),
	})


func init_RED_GOOPY_BOY() -> void:
	name = "Red Goopy Boy"
	set_effect(Effect.Type.OUTPUT_AND_INPUT, 1.4)
	add_effected_lored(LORED.Type.MALIGNANCY)
	cost = Cost.new({
		Currency.Type.IRON: Attribute.new(30000, false),
		Currency.Type.COPPER: Attribute.new(30000, false),
		Currency.Type.MALIGNANCY: Attribute.new(50, false),
	})






func set_effect(_type: int, base_value: float, effected_input = -1) -> void:
	effect = Effect.new(_type, {
		"effect value": base_value,
		"effected_input": effected_input,
	})


func add_effected_lored(_type: int) -> void:
	var lored = lv.get_lored(_type)
	loreds.append(lored)
	effect.add_effected_lored(lored)


func add_effected_stage(_stage: int) -> void:
	loreds = lv.get_loreds_in_stage(_stage)
	for lored in loreds:
		effect.add_effected_lored(lored)



# - Actions

func purchase() -> void:
	if purchased or will_apply_effect:
		return
	cost.purchase(true)
	if special:
		will_apply_effect = true
		await gv.get("stage_" + str(stage) + "_reset")
		if not will_apply_effect:
			return
	purchased = true
	effect.apply()
	times_purchased += 1
	up.add_upgrade_count(upgrade_tab)
	emit_signal("just_purchased")
	emit_signal("purchased_changed")
	up.emit_signal("upgrade_purchased", type)




# - Get

func get_effect_text() -> String:
	return effect.get_text()


func get_effected_loreds_text() -> String:
	if effected_loreds_text != "":
		return effected_loreds_text
	var arr := []
	for lored in loreds:
		arr.append(lored.colored_name)
	return "[i]for [/i]" + gv.get_list_text_from_array(arr).replace("and", "[i]and[/i]")
