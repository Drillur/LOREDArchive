@icon("res://Sprites/reactions/STONE_HAPPY_STONE0.png")
class_name LOREDVico
extends MarginContainer




func load_finished() -> void:
	visible = lored.unlocked.get_value()
	lored_leveled_up(lored.level)


func load_started() -> void:
	stop_progress_bar()



@onready var fuel_bar = %"Fuel Bar" as Bar
@onready var info = %Info as IconButton
@onready var jobs = %Jobs as IconButton
@onready var sleep = %Sleep as IconButton
@onready var progress_bar = %"Progress Bar" as Bar
@onready var level_up = %"Level Up" as IconButton
@onready var active_buffs = %"Active Buffs" as IconButton
@onready var view_special = %"View Special" as IconButton
@onready var left_down = %LeftDown
@onready var right_down = %RightDown
@onready var output_texts = %"Output Texts"
@onready var currency = %Currency as CurrencyVico
@onready var status = %Status
@onready var name_and_icon = %"Name and Icon"
@onready var lored_icon = %"LORED Icon"
@onready var lored_name = %"LORED Name"
@onready var animation = %AnimatedSprite2D as LOREDAnimation
@onready var emote_container = %"Emote Container"
@onready var sleep_text_timer = $"Sleep Text Timer"
@onready var sleep_timer = $"Sleep Timer"
@onready var level_up_texts = %"Level Up Texts"
@onready var fuel_background = %"Fuel Background"
@onready var details = %Details

signal lored_details_requested(lored)

var prefer_left_down: bool
var has_lored := false
var lored: LORED
var current_job: Job
var pending_outputs := {}
var last_text_clock := Time.get_unix_time_from_system()

const sleep_text_pool := [
	"[i]Z", "[i]z", "[i]Zz", "[i]zZ", "[i]Zzz", "[i]zzZ", "[i]zZz", "[i]ZzZ",
	"Memememe...",
]


func _on_item_rect_changed():
	if not is_node_ready():
		await ready
	right_down.position.x = size.x + 10
	
	var center_node = size.x / 2
	if global_position.x + center_node <= get_viewport_rect().size.x / 2:
		prefer_left_down = false
	else:
		prefer_left_down = true



func _ready():
	# ref
	status.hide()
	#progress_bar.hide()
	fuel_bar.size.x = size.x
	
	jobs.hide()
	active_buffs.hide()
	view_special.hide()
	sleep.hide()
	
	sleep_text_timer.connect("timeout", spew_sleep_text)
	sleep_text_timer.connect("timeout", start_spewing_sleep_text)
	sleep_timer.connect("timeout", spent_one_second_asleep)
	sleep_timer.connect("timeout", start_sleep_timer)
	details.pressed.connect(emit_details)
	
	SaveManager.connect("load_finished", load_finished)
	SaveManager.connect("load_started", load_started)
	
	lv.sleep_unlocked.changed.connect(sleep_lock)
	lv.advanced_details_unlocked.changed.connect(advanced_details_lock)



func attach_lored(_lored: LORED) -> void:
	lored = _lored
	has_lored = true
	
	# signals
	gv.prestige.connect(prestige)
	lored.connect("leveled_up", lored_leveled_up)
	lored.cost.affordable.connect_and_call("changed", cost_update)
	level_up.button.connect("pressed", purchase_level_up)
	sleep.button.connect("pressed", sleep_clicked)
	lored.asleep.changed.connect(sleep_changed)
	fuel_bar.attach_attribute(lored.fuel)
	fuel_background.self_modulate = wa.get_color(lored.fuel_currency)
	lored.connect("became_unable_to_work", start_idle)
	lored.connect("leveled_up", flash_on_level_up)
	lored.unlocked.became_true.connect(show)
	lored.unlocked.became_true.connect(display_all_parent_nodes)
	lored.unlocked.became_false.connect(hide)
	lored.purchased.changed.connect(purchased_changed)
	lored.autobuy.changed.connect(autobuy_changed)
	lored.received_buff.connect(buffs_lock)
	lored.purchased.changed.connect(buffs_lock)
	lored.purchased.changed.connect(sleep_lock)
	lored.unlocked.changed.connect(sleep_lock)
	lored.purchased.changed.connect(advanced_details_lock)
	
	advanced_details_lock()
	buffs_lock()
	sleep_lock()
	
	info.button.connect("mouse_entered", show_info_tooltip)
	info.button.connect("mouse_exited", gv.clear_tooltip)
	level_up.button.connect("mouse_entered", show_level_up_tooltip)
	level_up.button.connect("mouse_exited", gv.clear_tooltip)
	sleep.button.connect("mouse_entered", show_sleep_tooltip)
	sleep.button.connect("mouse_exited", gv.clear_tooltip)
	jobs.button.connect("mouse_entered", show_jobs_tooltip)
	jobs.button.connect("mouse_exited", gv.clear_tooltip)
	active_buffs.mouse_entered.connect(show_lored_buffs_tooltip)
	active_buffs.mouse_exited.connect(gv.clear_tooltip)
	
	for job in lored.jobs:
		lored.jobs[job].connect("cut_short", job_cut_short)
	
	# ref
	$bg.self_modulate = lored.details.color
	progress_bar.color = lored.details.color
	progress_bar.modulate.a = 0.1
	fuel_bar.color = wa.get_color(lored.fuel_currency)
	#fuel_bar.modulate = Color(0.75, 0.75, 0.75)
	lored_name.modulate = lored.details.color
	info.color = lored.details.alt_color
	jobs.color = lored.details.alt_color
	active_buffs.color = lored.details.alt_color
	sleep.color = lored.details.alt_color
	view_special.color = lored.details.alt_color
	level_up.color = lored.details.alt_color
	details.modulate = lored.details.color
	
	info.button.mouse_default_cursor_shape = Control.CURSOR_ARROW
	jobs.button.mouse_default_cursor_shape = Control.CURSOR_ARROW
	active_buffs.button.mouse_default_cursor_shape = Control.CURSOR_ARROW
	animation.setup(lored)
	animation.modulate = lored.details.alt_color
	level_up.show_check() if lored.cost.affordable.is_true() else level_up.hide_check()
	currency.hide_threshold()
	lored_name.text = lored.details.name + ", " + lored.details.get_title()
	lored_icon.texture = lored.details.icon
	
	hide()


func cost_update() -> void: 
	var val = lored.cost.affordable.get_value()
	level_up.check.visible = val
	if val:
		flash_level_up_button()


func prestige(stage: int) -> void:
	if stage >= lored.stage:
		status.hide()
		animation.capped_anim.set_to(false)



# - Tooltip


func show_info_tooltip() -> void:
	gv.new_tooltip(gv.Tooltip.LORED_INFO, get_preferred_side(), {"lored": lored.type})


func show_level_up_tooltip() -> void:
	gv.new_tooltip(gv.Tooltip.LORED_LEVEL_UP, get_preferred_side(), {"lored": lored.type})


func show_sleep_tooltip() -> void:
	gv.new_tooltip(gv.Tooltip.LORED_SLEEP, get_preferred_side(), {"lored": lored.type})


func show_jobs_tooltip() -> void:
	gv.new_tooltip(gv.Tooltip.LORED_JOBS, get_preferred_side(), {"lored": lored.type})


func show_lored_buffs_tooltip() -> void:
	gv.new_tooltip(gv.Tooltip.LORED_BUFFS, get_preferred_side(), {"lored": lored.type})


func get_preferred_side() -> Node:
	return left_down if prefer_left_down else right_down



# - Ref Shit


func purchased_changed() -> void:
	var purchased = lored.purchased.get_value()
	if not purchased:
		stop_progress_bar()
		active_buffs.hide()
		view_special.hide()
		currency.hide()
		name_and_icon.show()
	else:
		name_and_icon.hide()
		currency.show()
		currency.setup(lored.primary_currency)
		if lv.sleep_unlocked.is_true():
			sleep.show()
		if lv.advanced_details_unlocked.is_true():
			jobs.show()


func lored_leveled_up(_level: int) -> void:
	if not lored.last_purchase_forced and Engine.get_frames_per_second() >= 60:
		
		var text = FlyingText.new(
			FlyingText.Type.LEVEL_UP,
			level_up_texts,
			level_up_texts,
			[0, 0],
		)
		text.add({
			"lored": lored.type,
		})
		text.go()



func job_completed() -> void:
	if Engine.get_frames_per_second() < 60:
		pending_outputs.clear()
	elif current_job.has_produced_currencies:
		
		if animation.capped_anim.is_true():
			for cur in current_job.last_production:
				if not cur in pending_outputs:
					pending_outputs[cur] = Big.new(current_job.last_production[cur])
				else:
					pending_outputs[cur].a(current_job.last_production[cur])
			
			if Time.get_unix_time_from_system() - last_text_clock > 1.0:
				var text = FlyingText.new(
					FlyingText.Type.CURRENCY,
					output_texts,
					output_texts,
					[0, 0],
				)
				for cur in pending_outputs:
					text.add({
						"cur": cur,
						"text": "+" + pending_outputs[cur].text,
						"crit": false,
					})
				text.go()
				pending_outputs.clear()
				last_text_clock = Time.get_unix_time_from_system()
		
		else:
			var text = FlyingText.new(
				FlyingText.Type.CURRENCY,
				output_texts,
				output_texts,
				[0, 0],
			)
			for cur in current_job.last_production:
				text.add({
					"cur": cur,
					"text": "+" + current_job.last_production[cur].text,
					"crit": false,
				})
			text.go()
			last_text_clock = Time.get_unix_time_from_system()
	progress_bar.stop()


func job_cut_short() -> void:
	if current_job.has_required_currencies and Engine.get_frames_per_second() >= 60:
		var text = FlyingText.new(
			FlyingText.Type.CURRENCY,
			output_texts,
			output_texts,
			[1, 1],
		)
		for cur in current_job.in_hand_input:
			text.add({
				"cur": cur,
				"text": "+" + current_job.in_hand_input[cur].text,
				"crit": false,
			})
		text.go()
		
	stop_progress_bar()


func flash_level_up_button() -> void:
	gv.flash(level_up, Color(0, 1, 0))


func flash_on_level_up(_level: int) -> void:
	gv.flash(self, lored.details.color)


func sleep_lock() -> void:
	sleep.visible = (
		lv.sleep_unlocked.is_true()
		and lored.unlocked.is_true()
		and lored.purchased.is_true()
	)# or gv.dev_mode
	if sleep.visible:
		gv.flash(sleep, lored.details.color)


func advanced_details_lock() -> void:
	jobs.visible = (
		lv.advanced_details_unlocked.is_true()
		and lored.unlocked.is_true()
		and lored.purchased.is_true()
	)
	if jobs.visible:
		gv.flash(jobs, lored.details.color)


func buffs_lock() -> void:
	active_buffs.visible = (
		Buffs.object_has_buff(lored)
		and lored.unlocked.is_true()
		and lored.purchased.is_true()
	)
	if active_buffs.visible:
		gv.flash(active_buffs, lored.details.color)


func autobuy_changed() -> void:
	var autobuy = lored.autobuy.get_value()
	level_up.autobuyer.visible = autobuy
	if autobuy:
		level_up.autobuyer.play()



# - Actions


func purchase_level_up() -> void:
	if lored.cost.affordable.is_true() or gv.dev_mode:
		lored.manual_purchase()
	else:
		gv.get_tooltip().get_price_node().flash()


func start_job(_job: Job) -> void:
	current_job = _job as Job
	progress_bar.start(current_job.duration.get_as_float())
	set_status_and_currency(current_job.status_text, current_job.get_primary_currency())
	animation.play_job_animation(current_job)


func stop_progress_bar() -> void:
	progress_bar.stop()
	animation.sleep()


func set_status_and_currency(_status: String, _currency: int) -> void:
	if _status == "":
		status.hide()
	else:
		status.show()
		status.text = "[i]" + _status
	
	currency.show()
	currency.setup(_currency)


func sleep_clicked() -> void:
	if lored.asleep.is_true():
		lored.wake_up()
	else:
		lored.go_to_sleep()


func sleep_changed() -> void:
	if lored.asleep.is_true():
		sleep.set_icon(res.get_resource("awake"))
		set_status_and_currency("[wave amp=20 freq=1]Sleeping.", lored.primary_currency)
		animation.sleep()
		start_spewing_sleep_text()
		start_sleep_timer()
	else:
		sleep.set_icon(res.get_resource("Halt"))
		sleep_text_timer.stop()
		sleep_timer.stop()


func start_idle() -> void:
	if lored.reason_cannot_work == LORED.ReasonCannotWork.UNKNOWN:
		set_status_and_currency("", lored.primary_currency)
	animation.sleep()


func start_sleep_timer() -> void:
	if lored.asleep.is_true() and sleep_timer.is_stopped():
		sleep_timer.start(1)


func spent_one_second_asleep() -> void:
	lored.emit_signal("spent_one_second_asleep")


func start_spewing_sleep_text() -> void:
	if lored.asleep.is_true() and sleep_text_timer.is_stopped():
		sleep_text_timer.start(randf_range(3, 6))


func spew_sleep_text() -> void:
	if Engine.get_frames_per_second() >= 60:
		var text = FlyingText.new(
			FlyingText.Type.SLEEP,
			output_texts,
			output_texts,
			[1, 1],
		)
		text.add({
			"color": lored.details.color,
			"text": sleep_text_pool[randi() % sleep_text_pool.size()],
		})
		text.go()



func emote(_emote: Emote) -> void:
	var emote_vico = res.get_resource("emote_vico").instantiate() as EmoteVico
	emote_vico.setup(_emote)
	emote_container.add_child(emote_vico)



func display_all_parent_nodes() -> void:
	display_parents(get_parent())


func display_parents(node) -> void:
	if node is MarginContainer:
		return
	if not node.visible:
		node.show()
	display_parents(node.get_parent())


func emit_details() -> void:
	lored_details_requested.emit(lored)
