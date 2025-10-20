extends Control

var cost := 10
var unboxing_scene = preload("res://shop/unboxing_scene/unboxing_scene.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_buy_pressed() -> void:
	if Global.coins >= cost:
		buy()

func buy(amount := 1):
	var bought_chars_array: Array = []
	for i in range(amount):
		Global.coins -= cost
		var rand_rarity = randf()
		var character: CharacterData
		if rand_rarity <= 0.9:
			character = Global.mage_apprentices.pick_random()
		elif rand_rarity <= 0.99:
			character = Global.mages.pick_random()
		else:
			character = Global.archmages.pick_random()
		character.owned += 1
		bought_chars_array.append(character)
	SceneManager.temp_scene_switch(unboxing_scene.instantiate(), {"characters": bought_chars_array})
	


func _on_buy_ten_pressed() -> void:
	if Global.coins >= cost*10:
		buy(10)
