extends Control
@onready var coins_text := $VBoxContainer/Panel/HBoxContainer/Panel/Coins
@onready var tab_container := $VBoxContainer/TabContainer

enum {Todo, Shop, Characters}

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Global.update_coins.connect(update_coin_value)


func update_coin_value():
	coins_text.text = "Coins: " + str(Global.coins)


func _on_todo_top_nav_pressed() -> void:
	tab_container.current_tab = Todo




func _on_shop_top_nav_pressed() -> void:
	tab_container.current_tab = Shop


func _on_char_top_nav_pressed() -> void:
	tab_container.current_tab = Characters
