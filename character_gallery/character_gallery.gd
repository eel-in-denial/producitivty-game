extends Control

var character_card_scene = preload("res://character_gallery/character_card/character_card.tscn")
var characters_owned: Array = []
@onready var gallery_grids = {
	"mage_apprentice": $MarginContainer/ScrollContainer/VBoxContainer/MageApprentices, 
	"mage": $MarginContainer/ScrollContainer/VBoxContainer/Mages, 
	"archmage": $MarginContainer/ScrollContainer/VBoxContainer/Archmages
	}

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Global.app_data_updated.connect(init_characters)

func init_characters():
	if Global.app_data.has("owned_characters"):
		characters_owned = Global.app_data["owned_characters"]
	add_character_cards(characters_owned)
	print(characters_owned)

func update_gallery(new_characters:Array):
	add_character_cards(new_characters)
	characters_owned.append_array(new_characters)
	print(characters_owned)
	
func add_character_cards(characters: Array):
	for char in characters:
		var char_card = character_card_scene.instantiate()
		char_card.initialise_info(char)
		gallery_grids[char["rarity"]].add_child(char_card)
		
