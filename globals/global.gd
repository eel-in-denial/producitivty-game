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

#dungeon game globals
var player_position

var mage_apprentices: Array[Dictionary] = [
	{"idx": 1, "name": "Godot Icon", "rarity": "mage_apprentice", "sprite": "res://characters/character_card_sprites/godot_icon.svg"}
]

var mages: Array[Dictionary] = [
	{"idx": 2, "name": "Godot Icon", "rarity": "mage", "sprite": "res://characters/character_card_sprites/godot_icon.svg"}
]

var archmages: Array[Dictionary] = [
	{"idx": 3, "name": "Godot Icon", "rarity": "archmage", "sprite": "res://characters/character_card_sprites/godot_icon.svg"}
]

func update_globals():
	if app_data.has("coins"):
		coins = app_data["coins"]
