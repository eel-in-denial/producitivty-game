extends Control

@onready var char_name := $VBoxContainer/Name
@onready var image := $VBoxContainer/TextureRect
@onready var owned := $VBoxContainer/Owned

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


func initialise_info(char: CharacterData):
	char_name.text = char.name
	image.texture = char.sprite
	owned.text = str(char.owned)
