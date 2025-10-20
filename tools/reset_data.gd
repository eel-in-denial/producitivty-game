@tool
extends Node2D
@export_tool_button("reset data") var reset_button = reset_data

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func reset_data():
	var file = FileAccess.open("user://data.json", FileAccess.WRITE)
	var data_json_string = JSON.stringify({
		"coins": 0,
		"tasks": [],
		"owned_characters": []
	}, "\t")
	file.store_string(data_json_string)
	file.close()
	print("✅ Saved data to: ", ProjectSettings.globalize_path("user://data.json"))
