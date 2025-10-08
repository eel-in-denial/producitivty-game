extends Node2D

var characters: Array
@onready var label := $CanvasLayer/Control/Label
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	characters = SceneManager.transition_data["characters"]


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.is_pressed():
			print(characters)
			if characters.front():
				label.text = "'" + characters[0]["name"] + "' has been summoned"
				characters.pop_front()
			else:
				SceneManager.return_from_temp()
