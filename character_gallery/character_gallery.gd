extends Control

var character_card_scene = preload("res://character_gallery/character_card/character_card.tscn")
var characters_owned: Array = []
@onready var gallery_grids = [
	$MarginContainer/ScrollContainer/VBoxContainer/MageApprentices, 
	$MarginContainer/ScrollContainer/VBoxContainer/Mages, 
	$MarginContainer/ScrollContainer/VBoxContainer/Archmages
	]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	add_character_cards(Global.mage_apprentices + Global.mages + Global.archmages)

func update_gallery(new_characters:Array):
	add_character_cards(new_characters)
	characters_owned.append_array(new_characters)
	print(characters_owned)
	
func add_character_cards(characters: Array):
	for char in characters:
		var char_card = character_card_scene.instantiate()
		gallery_grids[char.rarity].add_child(char_card)
		char_card.initialise_info(char)
		
		
