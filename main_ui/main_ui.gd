extends Control
@onready var coins_text := $VBoxContainer/Panel/HBoxContainer/Panel/Coins

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Global.update_coins.connect(update_coin_value)


func update_coin_value():
	coins_text.text = "Coins: " + str(Global.coins)
