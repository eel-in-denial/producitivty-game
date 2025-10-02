extends Control

@export var todo_list: VBoxContainer

@onready var edit_popup := $EditPopup
@export var edit_name: LineEdit
var todo_file = preload("res://todo_page/todo_item/todo_item.tscn")

func _ready() -> void:
	edit_popup.visible = false

func open_edit_popup():
	edit_popup.visible = true
	get_tree().paused = true

func close_edit_popup():
	edit_popup.visible = false
	get_tree().paused = false


func _on_add_item_pressed() -> void:
	open_edit_popup()
	

func _on_close_edit_pressed() -> void:
	close_edit_popup()


func _on_save_edit_pressed() -> void:
	var text = edit_name.text
	close_edit_popup()
	var todo_item = todo_file.instantiate()
	todo_item.text
	todo_list.add_child(todo_item)
