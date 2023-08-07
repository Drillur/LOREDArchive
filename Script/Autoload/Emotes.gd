extends Node



var saved_vars := [
	"completed_emotes",
	"random_emotes_allowed",
]

var emote_vico := preload("res://Hud/Emote/emote_vico.tscn")

signal random_emotes_became_allowed

var completed_emotes := []
var random_emotes_allowed := false:
	set(val):
		random_emotes_allowed = val
		if val:
			emit_signal("random_emotes_became_allowed")





# - Start

func new_game_start() -> void:
	
	start()


func loaded_game_start() -> void:
	
	start()



func start() -> void:
	unlock_random_emotes()
	start_all_main_emotes()
	start_random_emotes()



func start_all_main_emotes() -> void:
	emote(Emote.Type.COAL_GREET)
	emote(Emote.Type.COAL_WHOA)
	emote(Emote.Type.STONE_HAPPY)



func start_random_emotes() -> void:
	if not random_emotes_allowed:
		await random_emotes_became_allowed




# - Actions

func emote(emote_type: int) -> void:
	if is_emote_completed(emote_type):
		return
	
	var _emote = await Emote.new(emote_type)
	_emote.speaker.emote(_emote)
	
	if _emote.has_reply():
		if not _emote.ready_to_emote:
			await _emote.became_ready_to_emote
		var wait_time = max(3.0, _emote.duration / 2)
		await get_tree().create_timer(wait_time).timeout
		emote(_emote.reply)



func unlock_random_emotes() -> void:
	if not random_emotes_allowed:
		while await wi.wish_completed != Wish.Type.COLLECTION:
			pass
		random_emotes_allowed = true



# - Get

func is_emote_completed(emote_type: int) -> bool:
	return emote_type in completed_emotes
