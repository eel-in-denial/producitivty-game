extends Panel
@export var coin_amount = 5
@onready var name_label := $MarginContainer/Panel/Name
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$MarginContainer/Panel/Coins.text += str(coin_amount)


func edit(name := "", coins := 0):
	name_label.text = name


func _on_check_box_toggled(toggled_on: bool) -> void:
	if toggled_on:
		Global.coins += coin_amount
	else:
		Global.coins -= coin_amount


func _on_delete_pressed() -> void:
	queue_free()
