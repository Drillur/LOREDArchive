class_name Job
extends Resource



enum Type {
	REFUEL, 
	
	STONE, # 0
	COAL,
	IRON_ORE,
	COPPER_ORE,
	IRON,
	COPPER,
	GROWTH,
	JOULES,
	CONCRETE,
	MALIGNANCY,
	TARBALLS,
	OIL,
	
	WATER, # 12
	HUMUS,
	SEEDS,
	TREES,
	SOIL,
	AXES,
	WOOD,
	HARDWOOD,
	LIQUID_IRON, # 20
	STEEL,
	SAND,
	GLASS,
	DRAW_PLATE,
	WIRE,
	GALENA,
	LEAD,
	PETROLEUM,
	WOOD_PULP,
	PAPER, # 30
	PLASTIC,
	TOBACCO,
	CIGARETTES,
	CARCINOGENS,
	TUMORS,
	
	# WITCH
	PLANT_SEED,
	SIFT_SEEDS,
}

var TYPE_KEYS := Type.keys()

signal became_workable
signal began_working
signal stopped_working
signal completed
signal cut_short

var type: int
var lored: LORED

var crit: Attribute

var work_pass := -1.0
var clock_in_time: float

var key: String
var name := ""
var status_text := ""

var animation: SpriteFrames
var animation_key: String
var two_part_animation := false
var part_one_played := false

var added_rate := false
var working := false
var rate_requires_update := false

var has_sufficient_fuel := true
var has_produced_currencies := false
var produced_currencies := {}
var in_hand_output := {}
var has_required_currencies := false
var in_hand_input := {}
var required_currencies: Cost

var last_production := {}

var duration: Attribute
var fuel_cost: Attribute



func _init(_type: int) -> void:
	type = _type
	key = TYPE_KEYS[type]
	
	call("init_" + key)
	
	fuel_cost = Attribute.new(duration.get_as_float(), false)
	
	has_required_currencies = required_currencies != null
	has_produced_currencies = not produced_currencies.is_empty()
	
	hookup_required_currencies()



func init_REFUEL() -> void:
	name = "Refuel"
	duration = Attribute.new(4, false)
	status_text = "Refueling!"
	animation = preload("res://Sprites/animations/Refuel.tres")


func init_STONE() -> void:
	name = "Pick Up"
	duration = Attribute.new(2.5, false)
	animation = preload("res://Sprites/animations/stone.tres")
	add_produced_currency(Currency.Type.STONE, 1)


func init_COAL() -> void:
	name = "Dig"
	duration = Attribute.new(3.25, false)
	animation = preload("res://Sprites/animations/coal.tres")
	add_produced_currency(Currency.Type.COAL, 1)


func init_IRON_ORE() -> void:
	name = "Shoot"
	duration = Attribute.new(4, false)
	animation = preload("res://Sprites/animations/irono.tres")
	add_produced_currency(Currency.Type.IRON_ORE, 1)


func init_COPPER_ORE() -> void:
	name = "Mine"
	duration = Attribute.new(4, false)
	animation = preload("res://Sprites/animations/copo.tres")
	add_produced_currency(Currency.Type.COPPER_ORE, 1)


func init_IRON() -> void:
	name = "Toast"
	duration = Attribute.new(5, false)
	animation = preload("res://Sprites/animations/iron.tres")
	add_produced_currency(Currency.Type.IRON, 1)
	required_currencies = Cost.new({
		Currency.Type.IRON_ORE: Attribute.new(1, false)
	})


func init_COPPER() -> void:
	name = "Cook"
	duration = Attribute.new(5, false)
	animation = preload("res://Sprites/animations/cop.tres")
	add_produced_currency(Currency.Type.COPPER, 1)
	required_currencies = Cost.new({
		Currency.Type.COPPER_ORE: Attribute.new(1, false)
	})


func init_GROWTH() -> void:
	name = "Pop"
	duration = Attribute.new(6.5, false)
	animation = preload("res://Sprites/animations/growth.tres")
	add_produced_currency(Currency.Type.GROWTH, 1)
	required_currencies = Cost.new({
		Currency.Type.IRON: Attribute.new(1, false),
		Currency.Type.COPPER: Attribute.new(1, false),
	})


func init_JOULES() -> void:
	name = "Redirect"
	duration = Attribute.new(8.25, false)
	animation = preload("res://Sprites/animations/jo.tres")
	add_produced_currency(Currency.Type.JOULES, 1)
	required_currencies = Cost.new({
		Currency.Type.COAL: Attribute.new(1, false),
	})


func init_CONCRETE() -> void:
	name = "Mash"
	duration = Attribute.new(10, false)
	animation = preload("res://Sprites/animations/conc.tres")
	add_produced_currency(Currency.Type.CONCRETE, 1)
	required_currencies = Cost.new({
		Currency.Type.STONE: Attribute.new(1, false)
	})


func init_OIL() -> void:
	name = "Succ"
	duration = Attribute.new(0.5, false)
	animation = preload("res://Sprites/animations/oil.tres")
	add_produced_currency(Currency.Type.OIL, 0.075)


func init_TARBALLS() -> void:
	name = "Mutate"
	duration = Attribute.new(4, false)
	animation = preload("res://Sprites/animations/tar.tres")
	add_produced_currency(Currency.Type.TARBALLS, 1)
	required_currencies = Cost.new({
		Currency.Type.OIL: Attribute.new(1, false)
	})


func init_MALIGNANCY() -> void:
	name = "Manifest"
	duration = Attribute.new(5, false)
	animation = preload("res://Sprites/animations/malig.tres")
	add_produced_currency(Currency.Type.MALIGNANCY, 1)
	required_currencies = Cost.new({
		Currency.Type.TARBALLS: Attribute.new(1, false),
		Currency.Type.GROWTH: Attribute.new(1, false),
	})


func init_WATER() -> void:
	name = "Splish-Splash"
	duration = Attribute.new(3.25, false)
	animation = preload("res://Sprites/animations/water.tres")
	two_part_animation = true
	add_produced_currency(Currency.Type.WATER, 1)


func init_HUMUS() -> void:
	name = "Shit"
	duration = Attribute.new(4.575, false)
	animation = preload("res://Sprites/animations/humus.tres")
	add_produced_currency(Currency.Type.HUMUS, 1)
	required_currencies = Cost.new({
		Currency.Type.GROWTH: Attribute.new(0.5, false),
		Currency.Type.WATER: Attribute.new(1, false),
	})


func init_TREES() -> void:
	name = "Grow"
	duration = Attribute.new(20, false)
	animation = preload("res://Sprites/animations/tree.tres")
	add_produced_currency(Currency.Type.TREES, 1)
	required_currencies = Cost.new({
		Currency.Type.WATER: Attribute.new(6, false),
		Currency.Type.SEEDS: Attribute.new(1, false),
	})


func init_SEEDS() -> void:
	name = "Pollenate"
	duration = Attribute.new(5, false)
	animation = preload("res://Sprites/animations/seed.tres")
	two_part_animation = true
	add_produced_currency(Currency.Type.SEEDS, 1)
	required_currencies = Cost.new({
		Currency.Type.WATER: Attribute.new(1.5, false),
	})


func init_SOIL() -> void:
	name = "Scrape"
	duration = Attribute.new(5, false)
	animation = preload("res://Sprites/animations/soil.tres")
	add_produced_currency(Currency.Type.SOIL, 1)
	required_currencies = Cost.new({
		Currency.Type.HUMUS: Attribute.new(1.5, false),
	})


func init_AXES() -> void:
	name = "Assemble"
	duration = Attribute.new(7, false)
	animation = preload("res://Sprites/animations/axe.tres")
	add_produced_currency(Currency.Type.AXES, 1)
	required_currencies = Cost.new({
		Currency.Type.HARDWOOD: Attribute.new(0.8, false),
		Currency.Type.STEEL: Attribute.new(0.25, false),
	})


func init_WOOD() -> void:
	name = "Obliterate"
	duration = Attribute.new(5, false)
	animation = preload("res://Sprites/animations/wood.tres")
	add_produced_currency(Currency.Type.IRON, 25)
	required_currencies = Cost.new({
		Currency.Type.AXES: Attribute.new(5, false),
		Currency.Type.TREES: Attribute.new(1, false),
	})


func init_HARDWOOD() -> void:
	name = "Seduce"
	duration = Attribute.new(4.58333, false)
	animation = preload("res://Sprites/animations/hard.tres")
	add_produced_currency(Currency.Type.HARDWOOD, 1)
	required_currencies = Cost.new({
		Currency.Type.WOOD: Attribute.new(2, false),
		Currency.Type.CONCRETE: Attribute.new(1, false),
	})


func init_LIQUID_IRON() -> void:
	name = "Stew"
	duration = Attribute.new(4, false)
	animation = preload("res://Sprites/animations/liq.tres")
	add_produced_currency(Currency.Type.LIQUID_IRON, 1)
	required_currencies = Cost.new({
		Currency.Type.IRON: Attribute.new(10, false),
	})


func init_STEEL() -> void:
	name = "Slam"
	duration = Attribute.new(13 + (1.0/3), false)
	animation = preload("res://Sprites/animations/steel.tres")
	add_produced_currency(Currency.Type.STEEL, 1)
	required_currencies = Cost.new({
		Currency.Type.LIQUID_IRON: Attribute.new(8, false),
	})


func init_SAND() -> void:
	name = "Levitate"
	duration = Attribute.new(4, false)
	animation = preload("res://Sprites/animations/sand.tres")
	add_produced_currency(Currency.Type.SAND, 2.5)
	required_currencies = Cost.new({
		Currency.Type.HUMUS: Attribute.new(1.5, false),
	})


func init_GLASS() -> void:
	name = "Glass"
	duration = Attribute.new(5.825, false)
	animation = preload("res://Sprites/animations/glass.tres")
	add_produced_currency(Currency.Type.GLASS, 1)
	required_currencies = Cost.new({
		Currency.Type.SAND: Attribute.new(6, false),
	})


func init_DRAW_PLATE() -> void:
	name = "Doodle"
	duration = Attribute.new(10, false)
	animation = preload("res://Sprites/animations/draw.tres")
	add_produced_currency(Currency.Type.DRAW_PLATE, 1)
	required_currencies = Cost.new({
		Currency.Type.STEEL: Attribute.new(0.5, false),
	})


func init_WIRE() -> void:
	name = "Sew"
	duration = Attribute.new(5, false)
	animation = preload("res://Sprites/animations/wire.tres")
	add_produced_currency(Currency.Type.WIRE, 1)
	required_currencies = Cost.new({
		Currency.Type.COPPER: Attribute.new(5, false),
		Currency.Type.DRAW_PLATE: Attribute.new(0.4, false),
	})


func init_GALENA() -> void:
	name = "Jackhammer"
	duration = Attribute.new(4, false)
	animation = preload("res://Sprites/animations/gale.tres")
	add_produced_currency(Currency.Type.GALENA, 1)


func init_LEAD() -> void:
	name = "Filter"
	duration = Attribute.new(5, false)
	animation = preload("res://Sprites/animations/lead.tres")
	add_produced_currency(Currency.Type.LEAD, 1)
	required_currencies = Cost.new({
		Currency.Type.GALENA: Attribute.new(1, false),
	})


func init_PETROLEUM() -> void:
	name = "Process"
	duration = Attribute.new(5, false)
	animation = preload("res://Sprites/animations/pet.tres")
	add_produced_currency(Currency.Type.PETROLEUM, 1)
	required_currencies = Cost.new({
		Currency.Type.OIL: Attribute.new(3, false),
	})


func init_WOOD_PULP() -> void:
	name = "Strip"
	duration = Attribute.new(6 + (2.0/3), false)
	animation = preload("res://Sprites/animations/pulp.tres")
	add_produced_currency(Currency.Type.WOOD_PULP, 5)
	required_currencies = Cost.new({
		Currency.Type.STONE: Attribute.new(10, false),
		Currency.Type.WOOD: Attribute.new(5, false),
	})


func init_PAPER() -> void:
	name = "Paperify"
	duration = Attribute.new(5 + (1.0/3), false)
	animation = preload("res://Sprites/animations/paper.tres")
	add_produced_currency(Currency.Type.PAPER, 1)
	required_currencies = Cost.new({
		Currency.Type.WOOD_PULP: Attribute.new(0.6, false),
	})


func init_PLASTIC() -> void:
	name = "Pollute"
	duration = Attribute.new(6.25, false)
	animation = preload("res://Sprites/animations/plast.tres")
	add_produced_currency(Currency.Type.PLASTIC, 1)
	required_currencies = Cost.new({
		Currency.Type.COAL: Attribute.new(5, false),
		Currency.Type.PETROLEUM: Attribute.new(1, false),
	})


func init_TOBACCO() -> void:
	name = "Smoke"
	duration = Attribute.new(8 + (1.0/3), false)
	animation = preload("res://Sprites/animations/toba.tres")
	add_produced_currency(Currency.Type.TOBACCO, 1)
	required_currencies = Cost.new({
		Currency.Type.WATER: Attribute.new(2, false),
		Currency.Type.SEEDS: Attribute.new(1, false),
	})


func init_CIGARETTES() -> void:
	name = "Smoke"
	duration = Attribute.new(2.583333, false)
	animation = preload("res://Sprites/animations/ciga.tres")
	add_produced_currency(Currency.Type.CIGARETTES, 1)
	required_currencies = Cost.new({
		Currency.Type.TARBALLS: Attribute.new(4, false),
		Currency.Type.TOBACCO: Attribute.new(1, false),
		Currency.Type.PAPER: Attribute.new(0.25, false),
	})


func init_CARCINOGENS() -> void:
	name = "#note"
	duration = Attribute.new(7.5, false)
	animation = preload("res://Sprites/animations/carc.tres")
	add_produced_currency(Currency.Type.CARCINOGENS, 1)
	required_currencies = Cost.new({
		Currency.Type.MALIGNANCY: Attribute.new(3, false),
		Currency.Type.CIGARETTES: Attribute.new(6, false),
		Currency.Type.PLASTIC: Attribute.new(5, false),
	})


func init_TUMORS() -> void:
	name = "Grow"
	duration = Attribute.new(16 + (2.0/3), false)
	animation = preload("res://Sprites/animations/tum.tres")
	add_produced_currency(Currency.Type.TUMORS, 1)
	required_currencies = Cost.new({
		Currency.Type.GROWTH: Attribute.new(10, false),
		Currency.Type.MALIGNANCY: Attribute.new(5, false),
		Currency.Type.CARCINOGENS: Attribute.new(3, false),
	})


func assign_lored(_lored: LORED) -> void:
	lored = _lored
	crit = lored.crit
	lored.fuel.add_notify_increased_method(fuel_increased)
	lored.fuel.add_notify_decreased_method(fuel_decreased)
	if type == Type.REFUEL:
		var half = Big.new(lored.fuel.get_total()).d(2).toFloat()
		has_required_currencies = true
		required_currencies = Cost.new({
			lored.fuel_currency_type: Attribute.new(half, false)
		})
		hookup_required_currencies()
		animation_key = "refuel"
	else:
		animation_key = lored.key
	
	if has_produced_currencies:
		for cur in produced_currencies:
			wa.add_producer(cur, lored)


func hookup_required_currencies() -> void:
	if has_required_currencies:
		required_currencies.connect("became_affordable", required_currency_became_affordable)

func add_produced_currency(currency: int, amount: float) -> void:
	produced_currencies[currency] = Attribute.new(amount, false)



# - Signal

func lored_output_changed() -> void:
	rate_requires_update = true
	for x in produced_currencies.values():
		x.set_m_from_lored(lored.get_output())


func lored_input_changed() -> void:
	rate_requires_update = true
	required_currencies.increase_m_from_lored(lored.get_input())


func lored_haste_changed() -> void:
	rate_requires_update = true
	duration.set_d_from_lored(lored.get_haste())
	fuel_cost.set_d_from_lored(lored.get_haste())


func lored_fuel_cost_changed() -> void:
	rate_requires_update = true
	fuel_cost.set_m_from_lored(lored.get_fuel_cost())
	has_sufficient_fuel = lored.fuel.get_current().greater_equal(fuel_cost.get_value())


func required_currency_became_affordable() -> void:
	emit_signal("became_workable")


func fuel_increased() -> void:
	if has_sufficient_fuel:
		return
	if lored.fuel.get_current().greater_equal(fuel_cost.get_value()):
		has_sufficient_fuel = true


func fuel_decreased() -> void:
	if not has_sufficient_fuel:
		return
	if lored.fuel.get_current().less(fuel_cost.get_value()):
		has_sufficient_fuel = false



# - Actions

#might want to move reason why cannot work here somehow.
#it would probably work better than in lored

func can_start() -> bool:
	if lored.fuel.get_current_percent() <= lv.FUEL_DANGER and type != Type.REFUEL:
		return false
	if has_method("can_start_job_special_requirements_" + key):
		if not call("can_start_job_special_requirements_" + key):
			return false
	if has_required_currencies:
		if not required_currencies.affordable:
			return false
	return has_sufficient_fuel


func can_start_job_special_requirements_REFUEL() -> bool:
	if lored.fuel.get_current_percent() > lv.FUEL_WARNING:
		return false
	if lored.type != LORED.Type.COAL:
		if lv.get_lored(LORED.Type.COAL).fuel.get_current_percent() <= lv.FUEL_WARNING:
			return false
	return true



func should_refresh_rate() -> bool:
	if rate_requires_update:
		return true
	return lored.last_job != self


func add_current_rate() -> void:
	if added_rate:
		return
	var _duration = duration.get_as_float()
	if has_produced_currencies:
		for cur in produced_currencies:
			var currency = wa.get_currency(cur) as Currency
			currency.add_current_gain_rate(Big.new(in_hand_output[cur]).d(_duration))
	if has_required_currencies and type != Type.REFUEL:
		for cur in required_currencies.cost:
			var currency = wa.get_currency(cur) as Currency
			currency.add_current_loss_rate(Big.new(in_hand_input[cur]).d(_duration))
	added_rate = true
	rate_requires_update = false


func subtract_current_rate() -> void:
	if not added_rate:
		return
	var _duration = duration.get_as_float()
	if has_produced_currencies:
		for cur in produced_currencies:
			var currency = wa.get_currency(cur) as Currency
			currency.subtract_current_gain_rate(Big.new(in_hand_output[cur]).d(_duration))
	if has_required_currencies and type != Type.REFUEL:
		for cur in required_currencies.cost:
			var currency = wa.get_currency(cur) as Currency
			currency.subtract_current_loss_rate(Big.new(in_hand_input[cur]).d(_duration))
	added_rate = false



func start() -> void:
	if should_refresh_rate():
		subtract_current_rate()
	working = true
	if has_produced_currencies:
		in_hand_output.clear()
		for cur in produced_currencies:
			in_hand_output[cur] = produced_currencies[cur].get_value()
			wa.add_pending(cur, in_hand_output[cur])
	if has_required_currencies:
		required_currencies.spend(false)
		in_hand_input.clear()
		for cur in required_currencies.cost:
			in_hand_input[cur] = required_currencies.cost[cur].get_value()
	
	add_current_rate()
	
	lored.fuel.subtract(fuel_cost.get_total())
	lv.start_job_timer(self)
	emit_signal("began_working")


func stop() -> void:
	work_pass = -1.0
	no_longer_working()
	emit_signal("cut_short")


func complete() -> void:
	no_longer_working()
	last_production.clear()
	if has_produced_currencies:
		var multiplier := 1.0
		if randf_range(0, 100) < crit.get_as_float():
			multiplier = randf_range(7.5, 12.5)
		for cur in produced_currencies:
			last_production[cur] = in_hand_output[cur].m(multiplier)
			wa.add_from_lored(cur, last_production[cur])
	if has_method("complete_" + key):
		call("complete_" + key)
	emit_signal("completed")


func no_longer_working() -> void:
	working = false
	if has_produced_currencies:
		for cur in produced_currencies:
			wa.subtract_pending(cur, in_hand_output[cur])
	emit_signal("stopped_working")


func complete_REFUEL() -> void:
	lored.fuel.add_percent(0.5)



# - Get

func get_required_currency_types() -> Array:
	if not has_required_currencies:
		return []
	return required_currencies.cost.keys()


func get_required_currency(_currency: int) -> Attribute:
	return required_currencies.cost[_currency]


func get_primary_currency() -> int:
	if has_produced_currencies:
		return produced_currencies.keys()[0]
	elif has_required_currencies:
		return required_currencies.cost.keys()[0]
	return lored.primary_currency


func get_fuel_cost() -> Big:
	return fuel_cost.get_value()


func get_animation_key() -> String:
	if two_part_animation:
		if part_one_played:
			return animation_key + "2"
	elif type == Type.REFUEL:
		return animation_key + str(randi_range(0, 1))
	return animation_key


func get_attributes_by_currency(currency: int) -> Array:
	var arr := []
	if has_required_currencies:
		for cur in required_currencies.cost:
			if cur == currency:
				arr.append(required_currencies.cost[cur])
	return arr
