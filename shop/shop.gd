extends Control
var cost := 10

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_buy_pressed() -> void:
	if Global.coins >= cost:
		buy()

func buy():
	Global.coins -= cost


func _on_buy_ten_pressed() -> void:
	for i in range(10):
		if Global.coins >= cost:
			buy()
		else:
			break
