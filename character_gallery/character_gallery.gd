extends Control

var character_card_scene = preload("res://character_gallery/character_card/character_card.tscn")
var characters_owned: Array[Dictionary] = []
@onready var gallery_grids = {
	"common": $MarginContainer/ScrollContainer/VBoxContainer/Common, 
	"rare": $MarginContainer/ScrollContainer/VBoxContainer/Rare, 
	"epic": $MarginContainer/ScrollContainer/VBoxContainer/Epic, 
	"legendary": $MarginContainer/ScrollContainer/VBoxContainer/Legendary
	}

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func update_gallery(new_characters:Array):
	print("hekjasbdgf")
	add_character_cards(new_characters)
	characters_owned.append_array(new_characters)
	
func add_character_cards(characters: Array):
	for char in characters:
		var char_card = character_card_scene.instantiate()
		char_card.initialise_info(char)
		gallery_grids[char["rarity"]].add_child(char_card)
		print("skjdbf")
		
