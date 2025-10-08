extends Node

signal update_coins
signal app_data_updated

var app_data: Dictionary = {}:
	set(value):
		app_data = value
		update_globals()
		app_data_updated.emit()

var coins := 0:
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

func update_globals():
	if app_data.has("coins"):
		coins = app_data["coins"]
