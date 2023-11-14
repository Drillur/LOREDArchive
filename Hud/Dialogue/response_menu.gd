@icon("./assets/responses_menu.svg")
class_name DialogueResponsesMenuCustom
extends VBoxContainer


signal response_selected(response: DialogueResponse)


## Optionally specify a control to duplicate for each response
@export var response_template: Control
@export var scroll_container: ScrollContainer

# The list of dialogue responses.
var _responses: Array = []

var color: Color


func _ready() -> void:
	visibility_changed.connect(func():
		if visible and get_menu_items().size() > 0:
			get_menu_items()[0].grab_focus()
	)

	if is_instance_valid(response_template):
		response_template.get_parent().remove_child(response_template)


func _exit_tree() -> void:
	if is_instance_valid(response_template):
		response_template.free()


## Set the list of responses to show.
func set_responses(next_responses: Array, _color: Color) -> void:
	color = _color
	_responses = next_responses

	# Remove any current items
	for item in get_children():
		remove_child(item)
		item.queue_free()

	# Add new items
	if _responses.size() > 0:
		for response in _responses:
			response = response as DialogueResponse
			var item: Control
			if is_instance_valid(response_template):
				item = response_template.duplicate()
			else:
				item = Button.new()
			item.name = "Response%d" % get_child_count()
			if not response.is_allowed:
				item.name = String(item.name) + "Disallowed"
				item.disabled = true
			item.text = str(get_child_count() + 1) + ". ..."
			add_child(item)
			item.color = color
		
		_configure_focus()
		
		scroll_container.custom_minimum_size.y = min(36 * _responses.size(), 108)
		scroll_container.get_v_scroll_bar().modulate = color


# Prepare the menu for keyboard and mouse navigation.
func _configure_focus() -> void:
	var items = get_menu_items()
	for i in items.size():
		var item: Control = items[i]

		item.focus_mode = Control.FOCUS_ALL

		item.focus_neighbor_left = item.get_path()
		item.focus_neighbor_right = item.get_path()

		if i == 0:
			item.focus_neighbor_top = item.get_path()
			item.focus_previous = item.get_path()
		else:
			item.focus_neighbor_top = items[i - 1].get_path()
			item.focus_previous = items[i - 1].get_path()

		if i == items.size() - 1:
			item.focus_neighbor_bottom = item.get_path()
			item.focus_next = item.get_path()
		else:
			item.focus_neighbor_bottom = items[i + 1].get_path()
			item.focus_next = items[i + 1].get_path()

		item.mouse_entered.connect(_on_response_mouse_entered.bind(item))
		item.gui_input.connect(_on_response_gui_input.bind(item))

	items[0].grab_focus()


## Get the selectable items in the menu.
func get_menu_items() -> Array:
	var items: Array = []
	for child in get_children():
		if "Disallowed" in child.name: continue
		items.append(child)

	return items


### Signals


func _on_response_mouse_entered(item: Control) -> void:
	if "Disallowed" in item.name: return

	item.grab_focus()


func _on_response_gui_input(event: InputEvent, item: Control) -> void:
	if "Disallowed" in item.name: return
	
	if event is InputEventMouseButton and event.is_released() and event.button_index == 1:
		response_selected.emit(_responses[item.get_index()])
	elif event.is_action_released("ui_accept") and item in get_menu_items():
		response_selected.emit(_responses[item.get_index()])


func _on_dialogue_label_finished_typing():
	update_response_text()
	flash_responses()


func flash_responses() -> void:
	for response in get_children():
		gv.flash(response, color)


func update_response_text() -> void:
	var i = 0
	for response in _responses:
		response = response as DialogueResponse
		get_child(i).text = str(i + 1) + ". " + response.text
		i += 1