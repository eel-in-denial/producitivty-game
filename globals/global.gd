extends Node

signal update_coins

var app_data: Dictionary = {}

var coins := 500:
	set(value):
		coins = value
		update_coins.emit()
		
var common_characters: Array[Dictionary] = [
	{"name": "Godot Icon", "rarity": "common", "sprite": "res://characters/character_card_sprites/godot_icon.svg"}
]

var rare_characters: Array[Dictionary] = [
	{"name": "Godot Icon", "rarity": "rare", "sprite": "res://characters/character_card_sprites/godot_icon.svg"}
]

var epic_characters: Array[Dictionary] = [
	{"name": "Godot Icon", "rarity": "epic", "sprite": "res://characters/character_card_sprites/godot_icon.svg"}
]

var legendary_characters: Array[Dictionary] = [
	{"name": "Godot Icon", "rarity": "legendary", "sprite": "res://characters/character_card_sprites/godot_icon.svg"}
]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.
