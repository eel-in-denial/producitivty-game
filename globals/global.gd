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

var mage_apprentices: Array[CharacterData] = [
	preload("res://characters/character_data/test_apprentice.tres")
]

var mages: Array[CharacterData] = [
	preload("res://characters/character_data/test_mage.tres")
]

var archmages: Array[CharacterData] = [
	preload("res://characters/character_data/test_archmage.tres")
]

func update_globals():
	if app_data.has("coins"):
		coins = app_data["coins"]
