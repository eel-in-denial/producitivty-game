extends Control
@onready var coins_text := $VBoxContainer/Panel/HBoxContainer/Panel/Coins
@onready var tab_container := $VBoxContainer/TabContainer

enum {Todo, Game,  Shop, Characters}
var pages: Array[Node] = []

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pages = tab_container.get_children()
	
	Global.update_coins.connect(update_coin_value)
	pages[Shop].update_characters_owned.connect(update_character_gallery)
	if not FileAccess.file_exists("user://data.json"):
		save()
	load_json()

func update_coin_value():
	coins_text.text = "Coins: " + str(Global.coins)

func update_character_gallery(characters: Array):
	pages[Characters].update_gallery(characters)

func save():
	var file = FileAccess.open("user://data.json", FileAccess.WRITE)
	var data_json_string = JSON.stringify({
		"coins": Global.coins,
		"tasks": pages[Todo].todo_items_data,
		"owned_characters": pages[Characters].characters_owned
	}, "\t")
	file.store_string(data_json_string)
	file.close()
	print("✅ Saved data to: ", ProjectSettings.globalize_path("user://data.json"))

func load_json():
	if not FileAccess.file_exists("user://data.json"):
		return []  # no file yet
		
	var file = FileAccess.open("user://data.json", FileAccess.READ)
	if file:
		var content = file.get_as_text()
		var result: Dictionary = JSON.parse_string(content)
		
		file.close()
		Global.app_data = result

func _notification(what):
	if what == NOTIFICATION_WM_CLOSE_REQUEST:
		save()
		get_tree().quit()

func change_scene():
	save()
	queue_free()

func _on_todo_top_nav_pressed() -> void:
	tab_container.current_tab = Todo

func _on_shop_top_nav_pressed() -> void:
	tab_container.current_tab = Shop

func _on_char_top_nav_pressed() -> void:
	tab_container.current_tab = Characters

func _on_game_top_nav_pressed() -> void:
	tab_container.current_tab = Game
